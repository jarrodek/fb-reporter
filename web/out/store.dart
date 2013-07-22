part of fbreporter;
/// This class represents application storage.
/// It provides method to keep user data.
class AppStore {
  
  static AppStore _appStore;
  
  final String CONFIG_FILE_KEY = 'drive_config_file_key';
  final String CONFIG_FILE_KEY_ETAG = 'drive_config_file_key_etag';
  final String CONFIG_SPREADSHEET_CONFIG = 'drive_config_data';
  
  factory AppStore(){
    if(_appStore != null){
      return _appStore;
    }
    
    _appStore = new AppStore._internal();
    return _appStore;
  }
  
  /// Load Facebooks pages configuration:
  /// an associacion with corresponging spreadsheets. 
  /// TODO: add spreadsheet synchronization
  Future<HashMap<String, FacebookPageConfig>> loadPagesConfig(){
    Completer completer = new Completer();
    HashMap<String, FacebookPageConfig> cfg = _restoreSpreadsheetLocalStorage();
    return new Future.value(cfg);
  }
  
  /// Save current Facebook pages configuration - an associacion with 
  /// corresponding spreadsheets.
  void savePagesConfig(HashMap<String, FacebookPageConfig> config){
    _updateSpreadsheetLocalStorage(config);
  }
  
  /// Restore from local storage saved data.
  HashMap<String, FacebookPageConfig> _restoreSpreadsheetLocalStorage(){
    String localData = window.localStorage[CONFIG_SPREADSHEET_CONFIG];
    if(localData == null || localData.isEmpty){
      return null;
    }
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
  
  /// Save to local storage config data.
  void _updateSpreadsheetLocalStorage(HashMap<String, FacebookPageConfig> config){
    List data = [];
    config.forEach((String page, FacebookPageConfig cfg){
      data.add(cfg.toJsonMap());
    });
    String str = JSON.stringify(data);
    window.localStorage[CONFIG_SPREADSHEET_CONFIG] = str;
  }
  
  AppStore._internal();
}

@observable
class FacebookPageConfig extends Observable  {
  String __$fileId;
  String get fileId {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'fileId');
    }
    return __$fileId;
  }
  set fileId(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'fileId',
          __$fileId, value);
    }
    __$fileId = value;
  }
  String __$pageId;
  String get pageId {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'pageId');
    }
    return __$pageId;
  }
  set pageId(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'pageId',
          __$pageId, value);
    }
    __$pageId = value;
  }
  String __$raportConfig;
  String get raportConfig {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'raportConfig');
    }
    return __$raportConfig;
  }
  set raportConfig(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'raportConfig',
          __$raportConfig, value);
    }
    __$raportConfig = value;
  }
  String __$rowId;
  String get rowId {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'rowId');
    }
    return __$rowId;
  }
  set rowId(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'rowId',
          __$rowId, value);
    }
    __$rowId = value;
  }
  String __$sheetTitle;
  String get sheetTitle {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'sheetTitle');
    }
    return __$sheetTitle;
  }
  set sheetTitle(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'sheetTitle',
          __$sheetTitle, value);
    }
    __$sheetTitle = value;
  }
  String __$spreadsheetTitle;
  String get spreadsheetTitle {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'spreadsheetTitle');
    }
    return __$spreadsheetTitle;
  }
  set spreadsheetTitle(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'spreadsheetTitle',
          __$spreadsheetTitle, value);
    }
    __$spreadsheetTitle = value;
  }
  String __$sheetId;
  String get sheetId {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'sheetId');
    }
    return __$sheetId;
  }
  set sheetId(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'sheetId',
          __$sheetId, value);
    }
    __$sheetId = value;
  }
  
  Map toJsonMap(){
    var mapData = new Map();
    mapData["fileId"] = fileId;
    mapData["pageId"] = pageId;
    mapData["raportConfig"] = raportConfig;
    mapData["rowId"] = rowId;
    mapData['sheetTitle'] = sheetTitle;
    mapData['spreadsheetTitle'] = spreadsheetTitle;
    mapData['sheetId'] = sheetId;
    return mapData;
    //return JSON.stringify(mapData);
  }
  FacebookPageConfig();
}
//# sourceMappingURL=store.dart.map