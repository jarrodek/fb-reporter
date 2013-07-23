part of fbreporter;

class SpreadsheetService {
  
  static final List<String> PAGE_POSTS_COLUMNS_SET = ['Data','Entry','Attachment','Likes','Unique likes','Comment','Unique comment','Shares','Unique shares','Virality','Talking about this','Range','Paid boost'];
  
  static String getAppServiceUrl(){
    if(!useAppExternalServer && window.location.hostname.startsWith('127.')){
      return 'http://127.0.0.1:8080/api';
    }
    return 'https://fb-reporter.appspot.com/api';
  }
  
  /// Get Spreadsheet identified by [spreadsheetId] metadata
  /// from Google Drive and return in [Future] as a [SpreadsheetMeta]
  static Future<SpreadsheetMeta> getSpreadsheetMetaData(String spreadsheetId){
    fbi.spreadsheetUpdating = true;
    Completer completer = new Completer();
    
    HttpRequest request = new HttpRequest();
    String url = getAppServiceUrl();
    url += '/spreadsheet/getmeta?sheetid=$spreadsheetId';
    request.onError.listen((e){
      if(request.status == 0){
        completer.completeError(new Exception("Damn it Jim! Unable to connect application server: ${getAppServiceUrl()}"));
        return;
      }
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
        // Id looks like following
        //"https://spreadsheets.google.com/feeds/worksheets/SPREADSHEET_ID/od6"
        // We are looking for /od6 part
        id = id.substring(id.lastIndexOf('/')+1);
        
        sm.id = id;
        sm.title = entry['title'][r'$t'];
        result.sheets.add(sm);
      }
      completer.complete(result);
    });
    fbi.auth.login(immediate: true).then((var token){
      request.open('GET', url);
      request.setRequestHeader("access_token", "${token.data}");
      request.send();
    });
    
    return completer.future;
  }
  
  
  
  static Future<SheetMeta> addNewWorksheet(String name, String spreadsheetId, List<String> columns){
    Completer completer = new Completer();
    
    //1) Add worksheet
    //2) Update worksheet with new column structure
    
    HttpRequest request = new HttpRequest();
    String url = getAppServiceUrl();
    url += '/spreadsheet/addworksheet?sheetid=$spreadsheetId';
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
      
      if(!data.containsKey('entry')){
        completer.completeError(new Exception("Spreadsheet service response is invalid. [entry]"));
        return;
      }
      var entry = data['entry'];
      if(entry == null) {
        completer.completeError(new Exception("Spreadsheet service response is invalid. [entry]"));
        return;
      }
      String id = entry['id'][r'$t'];
      // Id looks like following
      //"https://spreadsheets.google.com/feeds/worksheets/SPREADSHEET_ID/od6"
      // We are looking for /od6 part
      id = id.substring(id.lastIndexOf('/')+1);
      String etag = entry[r'gd$etag'];
      //update worksheet structure
      updateSheetStructure(spreadsheetId, id, columns, etag)
      .then((var res){
        SheetMeta sm = new SheetMeta();
        sm.id = id;
        sm.title = name;
        completer.complete(sm);
      })
      .catchError((e){
        print('error');
        window.console.log(e);
        completer.completeError(e);
      });
      
    });
    
    String payload = '<entry xmlns="http://www.w3.org/2005/Atom" \n\txmlns:gs="http://schemas.google.com/spreadsheets/2006">\n';
    payload += '<title>$name</title>\n';
    payload += '<gs:rowCount>10</gs:rowCount>\n';
    payload += '<gs:colCount>${columns.length}</gs:colCount>\n';
    payload += '</entry>';
    
    fbi.auth.login(immediate: true).then((var token){
      request.open('POST', url);
      request.setRequestHeader("access_token", "${token.data}");
      request.send(payload);
    });
    
    return completer.future;
  }
  
  static Future updateSheetStructure(String spreadsheetId, String worksheetId, List<String> columns, String etag){
    Completer completer = new Completer();
    String worksheetFullId = 'https://spreadsheets.google.com/feeds/cells/$spreadsheetId/$worksheetId/private/full';
    String payload = '<feed xmlns="http://www.w3.org/2005/Atom"\n\txmlns:batch="http://schemas.google.com/gdata/batch"\n\txmlns:gs="http://schemas.google.com/spreadsheets/2006">\n';
    payload += '<id>$worksheetFullId</id>\n';
    var len = columns.length;
    for(var i=0; i<len; i++){
      var column = columns[i];
      var columnNumber = i+1;
      var cellId = '$worksheetFullId/R1C$columnNumber';
      payload += '<entry>\n';
      payload += '\t<batch:id>A$columnNumber</batch:id>\n';
      payload += '\t<batch:operation type="update"/>\n';
      payload += '\t<id>$cellId</id>\n';
      payload += '\t<link rel="edit" type="application/atom+xml"\n\thref="$cellId/version"/>';
      payload += '\t<gs:cell row="1" col="$columnNumber" inputValue="$column"/>\n';
      payload += '</entry>\n';
    }
    payload += '</feed>';
    
    
    HttpRequest request = new HttpRequest();
    String url = getAppServiceUrl();
    url += '/spreadsheet/updateworksheet?sheetid=$spreadsheetId/$worksheetId&et=$etag';
    request.onError.listen((e){
      completer.completeError(e);
    });
    request.onLoad.listen((_){
      print(_);
      completer.complete(_);
    });
    
    fbi.auth.login(immediate: true).then((var token){
      request.open('POST', url);
      request.setRequestHeader("access_token", "${token.data}");
      request.send(payload);
    });
    
    return completer.future;
  }
  
}


class InsightRequest {
  static bool _posting = false;
  static List<InsightPostObject> _postsQueue = new List<InsightPostObject>();
  static final int POSTS_LIMIT_IN_RUN = 5;
  
  /// Post data to spreadsheet
  /// This method require [data] parameter as a list of [FacebookPagePostInsight] structure.
  /// It will post data to [worksheetId] in [spreadsheetId].
  /// All data are keep in queue and send to apps server in packages. When all done [Future] will result with response.
  static Future<Map> postToSpreadsheet(List<FacebookPagePostInsight> data, String spreadsheetId, String worksheetId){
    Completer<Map> cpl = new Completer();
    
    InsightPostObject obj = new InsightPostObject(cpl, data, '$spreadsheetId/$worksheetId');
    _postsQueue.add(obj);
    Timer.run(run);
    
    return cpl.future;
  }
  
  
  ///Run the queue
  static void run(){
    if(_posting){
      return;
    }
    if(_postsQueue.length == 0){
      return;
    }
    InsightPostObject obj = _postsQueue[0];
    if(!obj.hasNext){
      obj.cpl.complete(obj.serverResult);
      _postsQueue.removeAt(0);
      Timer.run(run);
      return;
    }
    
    _posting = true;
    String worksheetId = obj.worksheetFullId;
    Iterable<FacebookPagePostInsight> list = obj.data.take(POSTS_LIMIT_IN_RUN);
    Iterator<FacebookPagePostInsight> it = list.iterator;
    String url = SpreadsheetService.getAppServiceUrl();
    url += '/spreadsheet/postinsights?worksheet=$worksheetId';
    
    fbi.auth.login(immediate: true).then((var token){
      var dataArray = [];
      
      while(it.moveNext()){
        FacebookPagePostInsight _post = it.current;
        String payload = _post.defaultPayload;
        var obj = {
          'post_id': _post.postId,
          'data': payload
        };
        dataArray.add(obj);
      }
      
      var headers = {};
      headers['access_token'] = token.data;
      headers['content_type'] = 'application/json; charset=UTF-8';
      var payload = JSON.stringify(dataArray);
      HttpRequest.request(url, method:"POST",requestHeaders:headers,sendData:payload)
        .then((HttpRequest response) => _parseServerAddInsightResponse(response.responseText))
        .then((Map data){
          obj.serverResult.addAll(data);
          obj.data.removeWhere((var el) {
            var res = false;
            dataArray.forEach((var o) { 
              if(o['post_id'] == el.postId){
                res=true;
              } 
            });
            return res;
          });
          _posting = false;
          //print('OK, finished current queue. Calling run again.');
          Timer.run(run);
        })
        .catchError((e){
          print('Post to spreadsheet error');
          window.console.log(e);
          Map _fakeRep = {};
          dataArray.forEach((var o){
            _fakeRep[o['post_id']] = 500;
          });
          obj.serverResult.addAll(_fakeRep);
          obj.data.removeWhere((var el) {
            var res = false;
            dataArray.forEach((var o) { 
              if(o['post_id'] == el.postId){
                res=true;
              } 
            });
            return res;
          });
          _posting = false;
          //print('OK, finished current queue (in error). Calling run again.');
          Timer.run(run);
        });
    });
  }
  
  static Map _parseServerAddInsightResponse(String data){
    
    var parsed = JSON.parse(data); //let him throw an error
    if(parsed == null){
      //parse error
      throw new Exception("Server response is empty");
    }
    
    var result = {};
    var len = parsed.length;
    for(int i=0; i<len; i++){
      var _rep = parsed[i];
      //at the moment we need "code" as the response status code and a "post_id" values to return.
      result[_rep['post_id']] = _rep['code'];
    }
    
    return result;
  }
  
  
}

class InsightPostObject {
  Completer<Map> cpl;
  List<FacebookPagePostInsight> data;
  String worksheetFullId;
  InsightPostObject(this.cpl, this.data, this.worksheetFullId);
  bool get hasNext => data.isNotEmpty;
  
  Map serverResult = new Map();
}






class SpreadsheetMeta {
  String id;
  String title;
  List<SheetMeta> sheets = new List();
}
class SheetMeta {
  String id;
  String title;
}