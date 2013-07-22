
/*
class AppStore {
  GoogleOAuth2 _auth;
  static AppStore _appStore;
  
  final String CONFIG_FILE_KEY = 'drive_config_file_key';
  final String CONFIG_FILE_KEY_ETAG = 'drive_config_file_key_etag';
  final String CONFIG_SPREADSHEET_CONFIG = 'drive_config_data';
  
  factory AppStore(GoogleOAuth2 auth){
    if(_appStore != null){
      return _appStore;
    }
    
    _appStore = new AppStore._internal(auth);
    return _appStore;
  }
  
  bool checkConfig(){
    return window.localStorage.containsKey(CONFIG_FILE_KEY);
  }
  /// First check if folder FacebookReporterFiles exists on Drive.
  /// If yes, look for 'raports_config' file. If exists it is our 
  /// config file.
  /// If not: 
  /// First - create folder named FacebookReporterFiles on Drive.
  /// Then create spreadsheets config file 'raports_config' and save 
  /// file key to local storage.
  Future<String> createDriveStorage(){
    Completer completer = new Completer();
    
    GDrive d = new GDrive(_auth);
    
    d.getConfigFileFolder()
      .then((String folderId) => d.createConfigFile(folderId))
      .then((String fileId){
        window.localStorage[CONFIG_FILE_KEY] = fileId;
        completer.complete(fileId);
      })
      .catchError((e) {
        completer.completeError(e);
      });
    
    
    return completer.future;
  }
  
  /// Get Spreadsheet identified by [spreadsheetId] metadata
  /// from Google Drive and return in [Future] as a [SpreadsheetMeta]
  Future<SpreadsheetMeta> getSpreadsheetMetaData(String spreadsheetId){
    Completer completer = new Completer();
    
    HttpRequest request = new HttpRequest();
    String url = getAppServiceUrl();
    url += '/spreadsheet/getcontent?getmeta=$spreadsheetId';
    request.onError.listen((e){
      completer.completeError(e);
    });
    request.onLoad.listen((_){
      Map data;
      try{
        data = JSON.parse(request.responseText);
      } catch(e){
        window.console.log(e);
        completer.completeError(e);
        return;
      }
      
      
      if(!data.containsKey('feed')){
        completer.completeError(new Exception("Spreadsheet service response is invalid. [Feed]"));
        return;
      }
      var feed = data['feed'];
      if(feed == null) return null;
      if(!feed.containsKey('entry')){
        completer.completeError(new Exception("Spreadsheet service response is invalid. [Entry]"));
        return;
      }
      SpreadsheetMeta result = new SpreadsheetMeta();
      result.title = feed['title'][r'$t'];
      result.id = spreadsheetId;
      
      var entries = feed['entry'];
      if(entries.length == 0){
        completer.completeError(new Exception("Spreadsheet service response is invalid. [Entry empty]"));
        return;
      }
      int len = entries.length;
      for(int i=0; i<len;i++){
        var entry = entries[i];
        SheetMeta sm = new SheetMeta();
        
        String id = entry['id'][r'$t'];
        // Id is looks like following
        //"https://spreadsheets.google.com/feeds/worksheets/SPREADSHEET_ID/od6"
        // We are looking for /od6 part
        id = id.substring(id.lastIndexOf('/')+1);
        
        sm.id = id;
        sm.title = entry['title'][r'$t'];
        result.sheets.add(sm);
      }
      completer.complete(result);
    });
    _auth.login(immediate: true).then((var token){
      request.open('GET', url);
      request.setRequestHeader("access_token", "${_auth.token.data}");
      request.send();
    });
    
    
    return completer.future;
  }
  
  
  
  
  Future<HashMap<String, FacebookPageConfig>> getspreadsheetConfigData(){
    Completer completer = new Completer();
    
    if(!checkConfig()){
      return new Future.error(new Exception("Config not ready"));
    }
    String key = window.localStorage[CONFIG_FILE_KEY];
    
    HttpRequest request = new HttpRequest();
    String url = getAppServiceUrl();
    url += '/spreadsheet/getcontent?sheetid=$key/od6';
    
    request.onError.listen((e){
      completer.completeError(e);
    });
    request.onLoad.listen((_){
      
      if(request.status == 304){
        // not modified
        var cfg = _restoreSpreadsheetLocalStorage();
        completer.complete(cfg);
        return;
      }
      
      Map data;
      try{
        data = JSON.parse(request.responseText);
      } catch(e){
        window.console.log(e);
        completer.completeError(e);
        return;
      }
      HashMap<String, FacebookPageConfig> config = _extractConfig(data);
      
      if(config != null){
        var feed = data['feed'];
        var feedEtag = feed[r'gd$etag'];
        window.localStorage['CONFIG_FILE_KEY_ETAG'] = feedEtag;
        _updateSpreadsheetLocalStorage(config);
      }
      completer.complete(config);
    });
    
    _auth.login(immediate: true).then((var token){
      request.open('GET', url);
      
      String etag = window.localStorage['CONFIG_FILE_KEY_ETAG'];
      if(etag != null){
        request.setRequestHeader("If-None-Match", "${etag}");
      }
      request.setRequestHeader("access_token", "${_auth.token.data}");
      request.send();
    });
    
    return completer.future;
  }
  
  ///Extract config data from spreadsheet
  ///Result format:
  ///   HashMap<(String) facebook_page_id, (Map) {fileId,pageId,raportConfig}>
  HashMap<String, FacebookPageConfig> _extractConfig(Map data){
    try{
      if(!data.containsKey('feed')){
        return null;
      }
      var feed = data['feed'];
      if(feed == null) return null;
      if(!feed.containsKey('entry')){
        return null;
      }
      
      var sheetTitle = feed['title'][r'$t'];
      
      var entries = feed['entry'];
      //if file was empty there will be no 'entry'
      if(entries == null) return null;
      
      if(entries.length == 0) return null;
      int len = entries.length;
      
      HashMap<String, FacebookPageConfig> result = new HashMap();
      
      for(int i=0; i<len;i++){
        var entry = entries[i];
        // Spreadsheet row ID helpful for update.
        var row_id = entry[r'id'][r'$t'];
        var file_id_entry = entry[r'gsx$drivefileid'];
        if(file_id_entry == null) continue;
        var page_id_entry = entry[r'gsx$pageid'];
        if(page_id_entry == null) continue;
        var raport_config_entry = entry[r'gsx$raportconfig'];
        if(raport_config_entry == null) continue;
        var spreadsheet_title_entry = entry[r'gsx$spreadsheettitle'];
        var sheet_id_entry = entry[r'gsx$sheetid'];
        
        
        FacebookPageConfig cfg = new FacebookPageConfig();
        
        cfg.fileId = file_id_entry[r'$t'];
        cfg.pageId = page_id_entry[r'$t'];
        cfg.raportConfig = raport_config_entry[r'$t'];
        cfg.rowId = row_id;
        cfg.sheetTitle = spreadsheet_title_entry[r'$t'];
        cfg.spreadsheetTitle = sheetTitle;
        cfg.sheetId = sheet_id_entry[r'$t'];
        
        result[cfg.pageId] = cfg;
      }
      return result;
    } catch(e){
      window.console.log(e);
      return null;
    }
  }
  
  void _updateSpreadsheetLocalStorage(HashMap<String, FacebookPageConfig> config){
    List data = [];
    
    config.forEach((String page, FacebookPageConfig cfg){
      data.add(cfg.toJsonMap());
    });
    
    String str = JSON.stringify(data);
    window.localStorage[CONFIG_SPREADSHEET_CONFIG] = str;
  }
  
  HashMap<String, FacebookPageConfig> _restoreSpreadsheetLocalStorage(){
    String localData = window.localStorage[CONFIG_SPREADSHEET_CONFIG];
    try{
      HashMap<String, FacebookPageConfig> config = new HashMap();
      var data = JSON.parse(localData);
      var len = data.length;
      for(int i=0; i<len; i++){
        FacebookPageConfig cfg = new FacebookPageConfig();
        var page = data[i];
        cfg.fileId = page['fileId'];
        cfg.pageId = page['pageId'];
        cfg.raportConfig = page['raportConfig'];
        cfg.rowId = page['rowId'];
        cfg.sheetTitle = page['sheetTitle'];
        cfg.spreadsheetTitle = page['spreadsheetTitle'];
        cfg.sheetId = page['sheetId'];
        
        config[cfg.pageId] = cfg;
      }
      return config;
    } catch(e){
      return null;
    }
  }
  
  
  void updateFacebookPageConfigFromFile(drivelib.File file, String facebookPageId){
    
    FacebookPageConfig completeUpdate(List responses){
      
      HashMap<String, FacebookPageConfig> config;
      SpreadsheetMeta meta;
      if(responses[0] is SpreadsheetMeta){
        meta = responses[0];
        config = responses[1];
      } else {
        config = responses[0];
        meta = responses[1];
      }
      
      FacebookPageConfig cfg;
      
      if(config != null && config.containsKey(facebookPageId)){
        cfg = config[facebookPageId];
      } else {
        cfg = new FacebookPageConfig();
        cfg.pageId = facebookPageId;
      }
      cfg.fileId = file.id;
      cfg.spreadsheetTitle = file.title;
      
      List<SheetMeta> sheets = meta.sheets;
      SheetMeta first = sheets.first;
      
      cfg.sheetTitle = first.title;
      cfg.sheetId = first.id;
      return cfg;
    }
    
    Future.wait([getspreadsheetConfigData(), getSpreadsheetMetaData(file.id)])
      .then((List responses) => completeUpdate(responses))
      .then((FacebookPageConfig cfg) => _updateFacebookPageConfig(cfg))
      .catchError((e){
        print('Error occured');
        window.console.log(e);
      });
  }
  /// Save to config spreadsheet file user settings.
  Future _updateFacebookPageConfig(FacebookPageConfig cfg){
    
    String payload = '';
    
    if(cfg.rowId == null){
      //Append to spreadsheet
      payload += '<entry xmlns="http://www.w3.org/2005/Atom" xmlns:gsx="http://schemas.google.com/spreadsheets/2006/extended">';
    } else {
      //update existing row
      payload += '<entry>';
      payload += '<id>${cfg.rowId}</id>';
      payload += '<category scheme="http://schemas.google.com/spreadsheets/2006" term="http://schemas.google.com/spreadsheets/2006#list"/>';
      payload += '';
      payload += '';
      
    }
  }
  
  
  
  String getAppServiceUrl(){
    if(window.location.hostname.startsWith('http://127.')){
      return 'http://localhost:8080/api';
    }
    return 'http://localhost:8080/api'; //TODO: service real URL.
  }
  
  AppStore._internal(this._auth);
}

*/