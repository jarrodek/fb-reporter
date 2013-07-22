library fbreporter;

import 'dart:html';
import 'dart:async';
import 'dart:collection';
import "dart:json" as JSON;
import 'dart:math' as Math;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:web_ui/web_ui.dart';
import "package:google_drive_v2_api/drive_v2_api_browser.dart" as drivelib;
import "package:google_oauth2_client/google_oauth2_browser.dart";
import 'package:js/js.dart' as js;
import 'package:web_ui/watcher.dart' as watchers;

part 'facebook.dart';
part 'drive.dart';
part 'store.dart';
part 'drive_picker.dart';
part 'spreadsheets.dart';
part 'toster.dart';

final CLIENT_ID = "933209257700.apps.googleusercontent.com";
final SCOPES = [drivelib.Drive.DRIVE_FILE_SCOPE,drivelib.Drive.DRIVE_SCOPE, 'https://spreadsheets.google.com/feeds','https://docs.google.com/feeds', 'https://www.googleapis.com/auth/userinfo.profile'];
final FB_SCOPES = ['manage_pages','read_insights'];

var fbi;
String get selectedPageClass => fbi.selectedPage == null ? '' : 'selectedPage';
String get selectedPostClass => fbi.selectedPost == null ? '' : 'selectedPost';
String get postsListClass => fbi.selectedPost == null ? 'span9' : 'span3';
String get chooserClass => fbi.selectedPage == null ? 'span12' : fbi.selectedPost == null ? 'span3':'span0';

void main() {
  initializeDateFormatting(window.navigator.language, null).then((_){});
  fbi = new FacebookInsights();
}

DateTime today = new DateTime.now();


class FacebookInsights {
  GoogleOAuth2 auth;
  
  @observable Token google_auth_token;
  @observable FacebookAuth fbauth;
  /// True if pages list is loading from Facebook API.
  @observable bool pagesListLoading = false;
  @observable bool pagePostListLoading = false;
  @observable bool spreadsheetUpdating = false;
  @observable bool pagePostInsightLoading = false;
  @observable List<FacebookPage> pagesList = toObservable([]);
  @observable List pagePostList = toObservable([]);
  bool get loading => pagesListLoading || pagePostListLoading || spreadsheetUpdating || pagePostInsightLoading;
  
  /// Token to the next page of posts on current page.
  @observable String nextPagePostToken;
  
  bool get isFacebookConnected => fbauth != null && fbauth.accessToken != '';
  bool get isGoogleConnected => google_auth_token != null;
  bool get isNextPagePostToken => nextPagePostToken != null;
  ///Currently selected page
  @observable String selectedPage;
  ///Currently selected post
  @observable String selectedPost;
  
  @observable HashMap<String, FacebookPageConfig> facebookPagesConfig = new HashMap();
  /// Get (if present) currently selected page config.
  @observable FacebookPageConfig get currentPageConfig => facebookPagesConfig.containsKey(selectedPage) ? facebookPagesConfig[selectedPage] : null;
  
  /// Holds cache of sheets list of spreadsheet. Displays will show it in dropdown list for change spreadsheet action.
  @observable Map spreadsheetSheetsList = toObservable(new Map());
  @observable bool spreadsheetSheetsListLoading = false;
  @observable PostsSelectionController postsSelectionController = new PostsSelectionController();
  @observable List pagePostInsights;
  
  
  DateTime dateRangeStart;
  DateTime dateRangeEnd;
  
  FacebookInsights(){
    auth = new GoogleOAuth2(CLIENT_ID, SCOPES);
    auth.login(immediate: true).then(handleGoogleToken);
    setUpFacebook();
    
  }
  
  void googleLogin(){
    auth.login().then(handleGoogleToken);
  }
  
  void googleLogout(){
    auth.logout();
    google_auth_token = null;
  }
  
  void facebookLogin(){
    FB.login(FB_SCOPES).then(_handleFacebookLogin).catchError((var error){
      //TODO: error catch
    });
  }
  
  void _handleFacebookLogin(var response){
    fbauth = response;
    if(fbauth != null && fbauth.accessToken != null){
      getUserFacebookPages();
    }
  }
  
  void handleGoogleToken(var token){
    auth.token = token;
    google_auth_token = token;
    
    
    //load pages config from Config Spreadsheet
    AppStore store = new AppStore();
    store.loadPagesConfig()
    .then((HashMap<String, FacebookPageConfig> config){
      if(config == null) config = new HashMap();
      facebookPagesConfig = config;
    });
  }
  
  void setUpFacebook(){
    js.context.onFacebookReady = new js.Callback.once(onFacebookReady);
    var script = new ScriptElement();
    script.src = '//connect.facebook.net/en_US/all.js';
    document.body.nodes.add(script);
  }
  
  void onFacebookReady(){
    FB.getLoginStatus().then(_handleFacebookLogin).catchError((var error){
      //TODO: error catch
    });
  }
  
  void selectPage(var pageId){
    selectedPage = pageId;
    
    Element el = query("#PageChooser *[data-selected-page=true]");
    if(el != null){
      el.attributes.remove('data-selected-page');
    }
    
    el = query('#PageChooser *[data-pageid="'+pageId+'"]');
    if(el != null){
      el.attributes.putIfAbsent('data-selected-page', (){ return 'true'; });
    }
    
    nextPagePostToken = null;
    pagePostList.clear();
    Element target = query('#SelectAllPostsToggle');
    if(target != null) {
      target.dataset.remove('state');
    }
    getPagePosts();
  }
  
  
  void loadNextPostsPage(Event e){
    e.preventDefault();
    getPagePosts();
  }
  
  void getPagePosts(){
    pagePostListLoading = true;
    var path = '';
    if(nextPagePostToken == null || nextPagePostToken.isEmpty){
      path = '/$selectedPage/posts?fields=id,message,story,created_time,picture,type,status_type';
      bool setLimit = false;
      if(dateRangeStart != null){
        int since = (dateRangeStart.millisecondsSinceEpoch/1000).round();
        path += "&since=$since";
        setLimit = true;
        //posts?void=true&since=1367359200&until=1369951200&limit=1000  //may 2013
      }
      if(dateRangeEnd != null){
        int until = (dateRangeEnd.millisecondsSinceEpoch/1000).round();
        path += "&until=$until";
        setLimit = true;
      }
      if(setLimit){
        path += "&limit=1000";
      }
      
    } else {
      path = nextPagePostToken;
    }
    
    FB.api(path).then((js.Proxy resp){
      pagePostListLoading = false;
      
      if(resp == null) {nextPagePostToken = null; return;}
      if(resp.data == null || resp.data.length == 0) {nextPagePostToken = null; return;}
      var len = resp.data.length;
      
      for(int i=0; i<len; i++){
        var p = resp.data[i];
        
        if(p['status_type'] == null){
          continue;
        }
        if(p['created_time'] != null){
          
          DateTime d = DateTime.parse(p['created_time']);
          DateFormat df = new DateFormat.yMMMMd(window.navigator.language).add_Hm();
          p['created_time'] = df.format(d);
        }
        
        var data = {};
        data['id'] = p['id'];
        data['message'] = p['message'];
        data['created_time'] = p['created_time'];
        data['picture'] = p['picture'];
        data['story'] = p['story'];
        data['type'] = p['type'];
        data['status_type'] = p['status_type'];
        pagePostList.add(data);
      }
      
      if(resp.paging != null && resp.paging.next != null){
        if(resp.paging.next == nextPagePostToken){
          nextPagePostToken = null;
          return;
        }
        nextPagePostToken = resp.paging.next;
      }
      js.release(resp);
    });
  }
  
  
  void getUserFacebookPages(){
    pagesListLoading = true;
    FB.api('/me/accounts').then((js.Proxy resp){
      pagesListLoading = false;
      var data = resp.data;
      int len = data.length;
      for(int i=0; i<len; i++){
        var p = data[i];
        FacebookPage page = new FacebookPage(p.category, p.name, p.access_token, p.id);
        pagesList.add(page);
      }
    });
  }
  
  
  void _createSpreadsheetForPage(){
    if(!isGoogleConnected) return;
    var dialog = query('#CreateSpreadsheetDialog');
    (query('#SpreadsheetName') as InputElement).value = '';
    
    if(dialog.classes.contains("hidden")){
      dialog.classes.remove("hidden");
    }
    dialog.xtag.show();
    
    StreamSubscription<MouseEvent> ev;
    ev = dialog.onClick.listen((Event e){
      Element el = e.target;
      if(el.dataset.containsKey('accept')){
        InputElement ie = query('#SpreadsheetName');
        var value = ie.value;
        
        GDrive d = new GDrive(auth);
        spreadsheetUpdating = true;
        d.createStructuredSpreadsheet(value, SpreadsheetService.PAGE_POSTS_COLUMNS_SET)
          .then((drivelib.File data) => SpreadsheetService.getSpreadsheetMetaData(data.id))
            .then((SpreadsheetMeta metadata) => updatePagesConfig(metadata))
            .then((_){spreadsheetUpdating = false;})
            .catchError((e){
              spreadsheetUpdating = false;
              print('error');
              window.console.log(e);
            });
        dialog.xtag.hide();
        ev.cancel();
      }
    });
  }
  
  /// Event handler to handle "select spreadsheet" action
  void _selectSpreadsheetForPage(){
    
    if(!isGoogleConnected) {
      new Toast.makeText("You must be signed in to Google Service to attach a spreadsheet.");
      return;
    }
    //TODO: dialog with information.
    
    
    auth.login(immediate: true).then((var token){
      DrivePicker dp = new DrivePicker();
      
      dp.createSpreadsheetPicker(token.data)
      .then((String sheetId) => SpreadsheetService.getSpreadsheetMetaData(sheetId))
      .then((SpreadsheetMeta metadata) => updatePagesConfig(metadata))
      .then((_){
        spreadsheetUpdating = false;
      })
      .catchError((e){
        spreadsheetUpdating = false;
        print('error');
        window.console.log(e);
        new Toast.makeText("Error occured: $e");
      });
    })
    .catchError((e){
      new Toast.makeText("Error occured: $e");
    });
  }
  
  
  void updatePagesConfig(SpreadsheetMeta metadata){
    FacebookPageConfig cfg;
    if(facebookPagesConfig.containsKey(selectedPage)){
      cfg = facebookPagesConfig[selectedPage];
    } else {
      cfg = new FacebookPageConfig();
      cfg.pageId = selectedPage;
    }
    SheetMeta sheet = metadata.sheets.first;
    cfg.sheetId = sheet.id;
    cfg.sheetTitle = sheet.title;
    cfg.spreadsheetTitle = metadata.title;
    cfg.fileId = metadata.id;
    facebookPagesConfig[selectedPage] = cfg;
    //watchers.dispatch();
    new AppStore().savePagesConfig(facebookPagesConfig);
  }
  
  ///Remove spreadsheet associacion from current page
  void _detachCurrentSpreadsheet(){
    if(!facebookPagesConfig.containsKey(selectedPage)){
      return;
    }
    FacebookPageConfig cfg = facebookPagesConfig[selectedPage];
    cfg.sheetId = null;
    cfg.sheetTitle = null;
    cfg.spreadsheetTitle = null;
    cfg.fileId = null;
    cfg.rowId = null;
    facebookPagesConfig[selectedPage] = cfg;
    
    new AppStore().savePagesConfig(facebookPagesConfig);
  }
  ///Replace currently attached sheet with other one from the same spreadsheet
  void _replaceSheet(var new_id){
    if(!spreadsheetSheetsList.containsKey(fbi.currentPageConfig.fileId)){
      return;
    }
    List<SheetMeta> metadata = spreadsheetSheetsList[fbi.currentPageConfig.fileId];
    String sheetTitle;
    for(SheetMeta meta in metadata){
      if(meta.id == new_id){
        sheetTitle = meta.title;
        break;
      }
    }
    if(sheetTitle == null){
      return;
    }
    FacebookPageConfig cfg = facebookPagesConfig[selectedPage];
    cfg.sheetId = new_id;
    cfg.sheetTitle = sheetTitle;
    facebookPagesConfig[selectedPage] = cfg;
    
    new AppStore().savePagesConfig(facebookPagesConfig);
  }
  /// Show dialog which allows a user create and attach new spreadsheet.
  void _addNewSheet(){
    if(!isGoogleConnected) return;
    var dialog = query('#CreateSheetDialog');
    (query('#SheetName') as InputElement).value = '';
    
    if(dialog.classes.contains("hidden")){
      dialog.classes.remove("hidden");
    }
    
    dialog.xtag.show();
    
    StreamSubscription<MouseEvent> ev;
    ev = dialog.onClick.listen((Event e){
      Element el = e.target;
      if(el.dataset.containsKey('accept')){
        InputElement ie = query('#SheetName');
        var value = ie.value;
        
        spreadsheetUpdating = true;
        SpreadsheetService.addNewWorksheet(value, fbi.currentPageConfig.fileId, SpreadsheetService.PAGE_POSTS_COLUMNS_SET)
          .then((SheetMeta meta){
            spreadsheetUpdating = false;
            FacebookPageConfig cfg = facebookPagesConfig[selectedPage];
            cfg.sheetId = meta.id;
            cfg.sheetTitle = meta.title;
            facebookPagesConfig[selectedPage] = cfg;
            new AppStore().savePagesConfig(facebookPagesConfig);
            updateWorksheetListInActionMenu();
          })
          .catchError((e){
            print('error');
            window.console.log(e);
          });
          
          dialog.xtag.hide();
          ev.cancel();
        }
      });
  }
  
  void updateWorksheetListInActionMenu(){
    spreadsheetSheetsListLoading = true;
    spreadsheetUpdating = true;
    SpreadsheetService.getSpreadsheetMetaData(fbi.currentPageConfig.fileId)
      .then((SpreadsheetMeta metadata){
        if(metadata.sheets.length > 0){
          spreadsheetSheetsList[fbi.currentPageConfig.fileId] = metadata.sheets;
        } else {
          if(spreadsheetSheetsList.containsKey(fbi.currentPageConfig.fileId)){
            spreadsheetSheetsList.remove(fbi.currentPageConfig.fileId);
          }
        }
        spreadsheetSheetsListLoading = false;
        spreadsheetUpdating = false;
      });
  }
  
  void addSelectionToWorksheet(){
    
    if(!facebookPagesConfig.containsKey(selectedPage)){
      new Toast.makeText("You must attach spreadsheet first.")
      ..show();
      return;
    }
    
    ElementList list = queryAll('#PostChooser :checked');
    if(list.isEmpty){
      new Toast.makeText("You need to select at least one post.")
      ..show();
      return;
    }
    List<String> postsList = new List();
    list.forEach((Element e) => postsList.add(e.dataset['postid']));
    if(postsList.isEmpty){
      new Toast.makeText("You need to select at least one post.")
      ..show();
      return;
    }
    
    _handlePostSendAction(postsList);
  }
  
  
  void _handlePostSendAction(List<String> postsList){
    
    //show loaders in posts list.
    postsList.forEach((String post_id) {
      Element indicator = query('[data-postindicator="$post_id"]');
      if(indicator != null){
        indicator.classes.remove("hidden");
        indicator.classes.add("loader progress progress-info progress-striped active");
      }
    });
    
    FacebookPageConfig cfg = facebookPagesConfig[selectedPage];
    pagePostInsightLoading = true;
    FB.downloadDefaultInsights(postsList)
      .then((List<FacebookPagePostInsight> data) => InsightRequest.postToSpreadsheet(data, cfg.fileId, cfg.sheetId))
      .then((Map serverResult){
        pagePostInsightLoading = false;
        //hide loaders in posts list.
        serverResult.forEach((String post_id, int server_response) {
          Element indicator = query('[data-postindicator="$post_id"]');
          if(indicator != null){
            if(server_response == 201){
              indicator.classes.add("hidden");
              indicator.classes.removeAll(["loader","progress","progress-info","progress-striped","active"]);
            } else {
              indicator.classes.removeAll(["active","progress-info"]);
              indicator.classes.add("progress-danger");
            }
          }
        });
        // look for posts which are not have statistics available
        // therefore they are not in the list. 
        ElementList emptyList = queryAll('[data-postindicator][class~="active"]');
        if(emptyList.isNotEmpty){
          new Toast.makeText("Some elements has not ben added to spreadsheet.").show();
        }
        emptyList.forEach((Element element){
          element.classes.removeAll(["progress-info","progress-striped","active"]);
          element.classes.add("progress-warning");
          
          Element conainer = element.parent.parent.parent;
          Element alert = conainer.query('[is="x-alert"]');
          window.console.log(alert);
          if(alert == null || alert.xtag == null) return;
          alert.classes.remove('hidden');
          alert.xtag.show();
          
        });
      })
      .catchError((e){
        print('error');
        window.console.log(e);
        pagePostInsightLoading = false;
        new Toast.makeText(e.toString(), Toast.LENGTH_INFINITY, true).show();
        
        //hide loaders that are OK and whow error for error.
        postsList.forEach((String post_id) {
          Element indicator = query('[data-postindicator="$post_id"]');
          if(indicator != null){
            indicator.classes.remove("active progress-info");
            indicator.classes.add("progress-danger");
          }
        });
      });
  }
  
  void postsListWrapperHandler(Event e){
    Element target = e.target;
    if(target.dataset['action'] != null){
      
      e.preventDefault();
      switch(target.dataset['action']){
        case 'add-single-post': 
          List<String> postsList = new List();
          postsList.add(target.dataset['postid']);
          _handlePostSendAction(postsList);
        break;
        case 'show-post-details':
          selectPost(target.dataset['postid']);
        break;
      }
    }
  }
  
  void performBackAction(){
    
    if(selectedPost != null){
      selectedPost = null;
      pagePostInsights = null;
      return;
    }
    
    
    selectedPage = null;
    Element el = query("#PageChooser *[data-selected-page=true]");
    if(el != null){
      el.attributes.remove('data-selected-page');
    }
    
    nextPagePostToken = null;
    pagePostList.clear();
  }
  
  List<String> _alowedExtenralAction = ['select-spreadsheet-for-page','create-spreadsheet-for-page','detach-spreadsheet-from-page','add-worksheet-to-page','replace-worksheet-for-page'];
  void performExternalAction(String action, [var data=null]){
    
    if(_alowedExtenralAction.indexOf(action) == -1) return;
    //print(action);
    switch(action){
      case 'select-spreadsheet-for-page': 
        _selectSpreadsheetForPage();
      break;
      case 'create-spreadsheet-for-page': 
        _createSpreadsheetForPage();
      break;
      case 'detach-spreadsheet-from-page':
        _detachCurrentSpreadsheet();
      break;
      case 'add-worksheet-to-page':
        _addNewSheet();
        break;
      case 'replace-worksheet-for-page':
        _replaceSheet(data);
        break;
    }
  }
  
  ///Select post for details
  void selectPost(String post_id){
    selectedPost = null;
    Timer.run(() => _selectPost(post_id));
  }
  
  void _selectPost(String post_id){
    selectedPost = post_id;
    
    String query = '#PostChooser [is="x-facebook-post-list-item"]';
    ElementList all = queryAll(query);
    all.forEach((Element _){
      if(_.xtag == null) return;
      if(_.dataset['id'] == post_id){
        _.xtag.selection = true;
      } else {
        _.xtag.selection = false;
      }
    });
    
    pagePostInsightLoading = true;
    
    Fql fql = new Fql();
    FqlQuery q1 = new FqlQuery();
    q1.table = 'insights';
    q1.metrics
    ..add('object_id')
    ..add('metric')
    ..add('value');
    q1
      ..addCondition('period', '= 0')
      ..addCondition('metric', 'IN ("post_impressions_unique","post_stories_by_action_type","post_story_adds_by_action_type_unique","post_storytellers")')
      ..addCondition('object_id', '= "$post_id"');
    
    
    //created_time
    FqlQuery q2 = new FqlQuery();
    q2.table = 'stream';
    q2.metrics.addAll(["post_id","created_time","message","type","attachment.media","attachment.fb_object_type","attachment.icon","permalink","description"]);
    q2
      ..addCondition('post_id', 'IN (SELECT object_id FROM #query1)');
    fql
      ..append(q1)
      ..append(q2);
    FB.downloadInsights(fql)
      .then((List data) {
        pagePostInsightLoading = false;
        if(data.length == 0){
          new Toast.makeText("No insights data available for this post", Toast.LENGTH_INFINITY, true).show();
          return;
        }
        
        pagePostInsights = data;
      })
      .catchError((e){
        print('error');
        window.console.log(e);
        pagePostInsightLoading = false;
        new Toast.makeText(e.toString(), Toast.LENGTH_INFINITY, true).show();
      });
  }
  
  void onDateRangeChange(Event e){
    Element picker = query('#DateSelector');
    if(picker.xtag == null){
      new Toast.makeText("Unable to get date range :(", Toast.LENGTH_INFINITY, true).show();
      return;
    }
    dateRangeStart = picker.xtag.selectionstart;
    dateRangeEnd = picker.xtag.selectionend;
    selectPage(selectedPage);
  }
  
}



class PostsSelectionController {
  
  /// True if single selection is on.
  bool get postSelectedMode => fbi.selectedPost != null;
  /// If single selection mode
  /// it will hold current selection
  String singleSelectedPostId;
  
  /// List of selected pages
  List<String> get selection {
    String query = '#PostChooser [is="x-facebook-post-list-item"]';
    ElementList all = queryAll(query);
    List<String> result = new List();
    all.forEach((Element _){
      if(_.xtag == null) return;
      result.add(_.dataset['id']);
    });
    return result;
  }
  
  void _clearSelection(){
    String query = '#PostChooser [is="x-facebook-post-list-item"]';
    ElementList all = queryAll(query);
    all.forEach((Element _){
      if(_.xtag == null) return;
      _.xtag.selection = false;
    });
  }
  
  void select(String post_id, bool state){
    if(postSelectedMode){
      if(post_id == fbi.selectedPost && !state){
        return;
      }
      _clearSelection();
      if(!state){
        return;
      }
    }
    String qry = '#PostChooser [is="x-facebook-post-list-item"][data-id="$post_id"]';
    Element post = query(qry);
    if(post == null || post.xtag == null) return;
    post.xtag.selection = state;
    if(postSelectedMode && state){
      fbi.selectPost(post_id);
    }
  }
}



/*
 
Update spreadsheet cells.

POST https://spreadsheets.google.com/feeds/cells/0Ajpy9PK_RiBOdDhfdjB2Mk1XbjFSZGNlQS00MUlkaHc/od6/private/full/batch
Gdata-version: 3.0
Content-type: application/atom+xml
Authorization: Bearer ya29.AHES6ZSkdmZkVGdjQHG480XRrvVkOpIQZfSBI8UqMyC1zdo
If-none-match: 686897696a7c876b7e


<feed xmlns="http://www.w3.org/2005/Atom"
      xmlns:batch="http://schemas.google.com/gdata/batch"
      xmlns:gs="http://schemas.google.com/spreadsheets/2006">
  <id>https://spreadsheets.google.com/feeds/cells/0Ajpy9PK_RiBOdDhfdjB2Mk1XbjFSZGNlQS00MUlkaHc/od6/private/full</id>
  <entry>
    <batch:id>A1</batch:id>
    <batch:operation type="update"/>
    <id>https://spreadsheets.google.com/feeds/cells/0Ajpy9PK_RiBOdDhfdjB2Mk1XbjFSZGNlQS00MUlkaHc/od6/private/full/R1C1</id>
    <link rel="edit" type="application/atom+xml"
      href="https://spreadsheets.google.com/feeds/cells/0Ajpy9PK_RiBOdDhfdjB2Mk1XbjFSZGNlQS00MUlkaHc/od6/private/full/R1C1/version"/>
    <gs:cell row="1" col="1" inputValue="newData"/>
  </entry>
  <entry>
    <batch:id>A2</batch:id>
    <batch:operation type="update"/>
    <title type="text">A2</title>
    <id>https://spreadsheets.google.com/feeds/cells/0Ajpy9PK_RiBOdDhfdjB2Mk1XbjFSZGNlQS00MUlkaHc/od6/private/full/R1C2</id>
    <link rel="edit" type="application/atom+xml" href="https://spreadsheets.google.com/feeds/cells/0Ajpy9PK_RiBOdDhfdjB2Mk1XbjFSZGNlQS00MUlkaHc/od6/private/full/R1C2/version"/>
    <gs:cell row="1" col="2" inputValue="moreInfo"/>
  </entry>
</feed>
 
 * */
