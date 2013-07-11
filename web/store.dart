part of fbreporter;

class AppStore {
  GoogleOAuth2 _auth;
  static AppStore _appStore;
  
  final String CONFIG_FILE_KEY = 'drive_config_file_key';
  
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
  
  Future getspreadsheetConfigData(){
    Completer completer = new Completer();
    
    if(!checkConfig()){
      return new Future.error(new Exception("Config not ready"));
    }
    String key = window.localStorage[CONFIG_FILE_KEY];
    GDrive d = new GDrive(_auth);
    
    return completer.future;
  }
  
  
  
  
  GDrive._internal(this._auth);
}