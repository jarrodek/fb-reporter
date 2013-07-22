part of fbreporter;

class GDrive {
  static GDrive _cache;
  
  
  final String spreadsheetContentType = 'application/vnd.google-apps.spreadsheet';
  drivelib.Drive _drive;
  GoogleOAuth2 _auth;
  
  Future createEmptySpreadsheet(String filenaName){
    
    Completer completer = new Completer();
    
    var newFile = new drivelib.File.fromJson({"title": filenaName, "mimeType": spreadsheetContentType});
    _drive.files.insert(newFile)
    .then((drivelib.File data) {
      //window.console.log(data);
      //print(data['alternateLink']);
      completer.complete(data);
    })
    .catchError((e) {
      //window.console.log(e);
      completer.completeError(e);
    });
    
    return completer.future;
  }
  
  
  Future<drivelib.File> createStructuredSpreadsheet(String filenaName, List<String> columns, [String parentId=null]){
    Completer completer = new Completer();
    
    var coulmnNames = columns.join(',');
    var base64Data = window.btoa(coulmnNames);
    var newFile = new drivelib.File.fromJson({"title": filenaName, "mimeType": "text/csv"});
    
    if(parentId != null){
      drivelib.ParentReference parent = new drivelib.ParentReference.fromJson({'id':parentId});
      newFile.parents = [parent];
    }
    
    _drive.files.insert(newFile, content: base64Data, contentType: "text/csv", convert: true)
    .then((drivelib.File data) {
      //window.console.log(data);
      //print(data['alternateLink']);
      completer.complete(data);
    })
    .catchError((e) {
      //window.console.log(e);
      completer.completeError(e);
    });
    
    return completer.future;
  }
  
  final String ATOM_SPREADSHEET_BATCH_HEADER = '''<feed xmlns="http://www.w3.org/2005/Atom"
      xmlns:batch="http://schemas.google.com/gdata/batch"
      xmlns:gs="http://schemas.google.com/spreadsheets/2006">''';
  
  
  
  Future updateSpreadsheetStructure(drivelib.File file, [String spreadsheetId='od6']){
    Completer completer = new Completer();
    
    var columnNames = ['Data','Entry','Attachment','Likes','Unique likes','Comment','Unique comment','Shares','Unique shares','Virality','Talking about this','Range'];
    var id_str = 'https://spreadsheets.google.com/feeds/cells/${file.id}/${spreadsheetId}/private/full';
    var payload = ATOM_SPREADSHEET_BATCH_HEADER;
    payload += '<id>$id_str<id>';
    
    int len = columnNames.length;
    
    for(var i=0; i<len; i++){
      var column_number = i+1;
      var column_address = '$id_str/R1C$column_number';
      var column_value = columnNames[i];
      payload += '<entry>';
      payload += '<batch:id>A$i</batch:id>';
      payload += '<batch:operation type="update"/>';
      payload += '<id>$column_address</id>';
      payload += '<link rel="edit" type="application/atom+xml" href="$column_address/version"/>';
      payload += '<gs:cell row="1" col="$column_number" inputValue="$column_value"/>';
      payload += '</entry>';
    }
    payload += '</feed>';
    
    HttpRequest request = new HttpRequest();
    request.onError.listen((e){
      print("ON ERROR EVENT");
      //completer.completeError(e);
    });
    request.onLoadEnd.listen((data){
      print("ON LOAD EVENT");
    });
    //request.onLoadEnd.listen((HttpRequest data){
      //completer.complete(data.responseText);
    //});
    request
      ..open('POST', '$id_str/batch')
      ..setRequestHeader('Gdata-version', '3.0')
      ..setRequestHeader('Content-type', 'application/atom+xml')
      ..setRequestHeader('If-none-match', '686897696a7c876b7e')
      ..setRequestHeader("Authorization", "${_auth.token.type} ${_auth.token.data}")
      ..send();
    return completer.future;
    /*
    var base64Data = window.btoa('');
    var updateFile = new drivelib.File.fromJson({"mimeType": spreadsheetContentType});
    _drive.files.update(updateFile, file.id, content: base64Data, contentType: spreadsheetContentType)
    .then((drivelib.File data) {
      completer.complete(data);
    }).catchError((e) {
      //window.console.log(e);
      completer.completeError(e);
    });
    */
    
  }
  
  Future<drivelib.File> getFile(String fileId){
    Completer completer = new Completer();
    
    if(fileId == null){
      completer.completeError(new Exception("File ID can't be empty."));
      return completer.future;
    }
    
    _drive.makeAuthRequests = true;
    _drive.files.get(fileId).then((drivelib.File file){
      completer.complete(file);
    });
    
    return completer.future;
  }
  ///Find or create Config folder on Google Drive.
  Future<String> getConfigFileFolder(){
    Completer completer = new Completer();
    
    String query = 'title=\'FacebookReporterFiles\' and mimeType=\'application/vnd.google-apps.folder\'';
    
    String findinResults(drivelib.FileList list){
      if(!list.items.any((drivelib.File file){ return file.title == 'FacebookReporterFiles'; })){
        return null;
      }
      String _id;
      list.items.forEach((drivelib.File file){
        if(file.title == 'FacebookReporterFiles'){
          _id = file.id;
        }
      });
      return _id;
    }
    
    Future<String> createIfNecessary(String fileid){
      if(fileid != null){
        return new Future.value(fileid);
      }
      return _createConfigFileFolder();
    }
    
    _drive.files.list(maxResults: 1, q: query)
            .then((drivelib.FileList list) => findinResults(list))
            .then((String fileId) => createIfNecessary(fileId))
            .then((String fileId){
              completer.complete(fileId);
            })
            .catchError((e) {
              completer.completeError(e);
            });
    
    return completer.future;
  }
  
  
  Future<String> createConfigFile(String parentId){
    Completer completer = new Completer();
    
    List<String> columns = ['page_id','sheet_id','drive_file_id','raport_config','spreadsheet_title','sheet_title'];
    createStructuredSpreadsheet('raports_config', columns, parentId)
      .then((drivelib.File file){
        completer.complete(file.id);
      })
      .catchError((e) {
        completer.completeError(e);
      });
    return completer.future;
  }
  
  
  Future<String> _createConfigFileFolder(){
    Completer completer = new Completer();
    var newFile = new drivelib.File.fromJson({"title": 'FacebookReporterFiles', "mimeType": 'application/vnd.google-apps.folder'});
    _drive.files.insert(newFile)
      .then((drivelib.File data) {
        completer.complete(data.id);
      })
      .catchError((e) {
        //window.console.log(e);
        completer.completeError(e);
      });
    return completer.future;
  }
  
  
  
  
  
  
  
  
  /*
  factory GDrive.revalidate(GoogleOAuth2 auth){
    _cache = null;
    var driveLib = new drivelib.Drive(auth);
    driveLib.makeAuthRequests = true;
    final GDrive drive = new GDrive._internal(driveLib, auth);
    
    _cache = drive;
    return drive;
  }
  */
  factory GDrive(GoogleOAuth2 auth){
    if(_cache != null){
      return _cache;
    }
    
    var driveLib = new drivelib.Drive(auth);
    driveLib.makeAuthRequests = true;
    final GDrive drive = new GDrive._internal(driveLib, auth);
    
    _cache = drive;
    return drive;
  }
  
  GDrive._internal(this._drive, this._auth);
}