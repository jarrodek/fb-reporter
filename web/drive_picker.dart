part of fbreporter;

class DrivePicker {
  
  bool loaded = false;
  bool loading = false;
  static DrivePicker _cache;
  var picker;
  
  factory DrivePicker(){
    if(_cache != null){
      return _cache;
    }
    _cache = new DrivePicker._internal();
    return _cache;
  }
  
  
  DrivePicker._internal();
  
  
  Future<bool> _load(){
    if(loaded){
      return new Future.value(true);
    }
    
    var completer = new Completer();
    
    if(loading == false){
      loading = true;
      
      var ctx = js.context;
      void loadedDriveApi(){
        completer.complete(true);
        loaded = true;
      }
      ctx.loadedDriveApi = new js.Callback.once(loadedDriveApi);
      //{"modules":[{"name":"picker","version":"1","callback":"loadedDriveApi"}]}
      document.body.nodes.add(new ScriptElement()..src = "//www.google.com/jsapi?autoload=%7B%22modules%22%3A%5B%7B%22name%22%3A%22picker%22%2C%22version%22%3A%221%22%2C%22callback%22%3A%22loadedDriveApi%22%7D%5D%7D");
      
    } else {
      //TODO: What if it already loading?
    }
    return completer.future;
  }
  
  /// Returns selected document. It may return null if user didn't pick any.
  Future<String> createSpreadsheetPicker([String authToken=null]){
    var completer = new Completer();
    
    _load().then((_){
      
      void appFilePickup(var data){
        
        if (data[picker.Response.ACTION] == picker.Action.PICKED) {
          var doc = data[picker.Response.DOCUMENTS][0];
          var docId = doc[picker.Document.ID];
          js.release(js.context.appFilePickup);
          completer.complete(docId);
        } else if(data[picker.Response.ACTION] == picker.Action.CANCEL){
          completer.complete(null);
        }
      }
      js.context.appFilePickup = new js.Callback.many(appFilePickup);
      
      picker = js.retain(js.context.google.picker);
      var inst = new js.Proxy(picker.PickerBuilder)
        ..setCallback(js.context.appFilePickup)
        ..addView(picker.ViewId.SPREADSHEETS)
        ..setOAuthToken(authToken);
      var builder = inst.build();
      builder.setVisible(true);
    });
    
    return completer.future;
  }
  
}