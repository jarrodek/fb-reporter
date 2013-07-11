library fbreporter;

import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:web_ui/web_ui.dart';
import "package:google_drive_v2_api/drive_v2_api_browser.dart" as drivelib;
import "package:google_oauth2_client/google_oauth2_browser.dart";
import 'package:js/js.dart' as js;
import 'package:widget/widget.dart';
import 'package:widget/effects.dart';
import 'package:widget/components/modal.dart';

part 'facebook.dart';

final CLIENT_ID = "796343192238.apps.googleusercontent.com";
final SCOPES = [drivelib.Drive.DRIVE_FILE_SCOPE,'https://spreadsheets.google.com/feeds','https://docs.google.com/feeds'];
final FB_SCOPES = ['manage_pages','read_insights'];


var startingCount = 0;
var fbi;
String get selectedPageClass => fbi.selectedPage == null ? '' : 'selectedPage';
String get chooserClass => fbi.selectedPage == null ? 'span12' : 'span3';
String get googleActionButtonsClass => fbi.isGoogleConnected ? '' : 'disabled';

void main() {
  initializeDateFormatting("window.navigator.language", null).then((_){});
  
  fbi = new FacebookInsights();
}



class FacebookInsights {
  GoogleOAuth2 auth;
  drivelib.Drive drive;
  
  @observable Token google_auth_token;
  @observable FacebookAuth fbauth;
  /// True if pages list is loading from Facebook API.
  @observable bool pagesListLoading = false;
  @observable bool pagePostListLoading = false;
  @observable List<FacebookPage> pagesList = toObservable([]);
  @observable List pagePostList = toObservable([]);
  bool get loading => pagesListLoading || pagePostListLoading;
  @observable String selectedPage;
  /// Token to the next page of posts on current page.
  @observable String nextPagePostToken;
  
  bool get isFacebookConnected => fbauth != null && fbauth.accessToken != '';
  bool get isGoogleConnected => google_auth_token != null;
  bool get isNextPagePostToken => nextPagePostToken != null;
  
  
  FacebookInsights(){
    auth = new GoogleOAuth2(CLIENT_ID, SCOPES);
    drive = new drivelib.Drive(auth);
    drive.makeAuthRequests = true;
    
    
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
  
  void togglePostsSelection(Event e){
    e.preventDefault();
    Element target = query('#SelectAllPostsToggle');
    if(target == null) return;
    var dataset = target.dataset;
    
    if(!dataset.containsKey('state') || dataset['state'] == 'none'){
      ElementList all = queryAll('#PostChooser input[type="checkbox"]:not(:checked)');
      all.forEach((CheckboxInputElement _){
        _.checked = true;
      });
      dataset['state'] = 'all';
    } else {
      ElementList all = queryAll('#PostChooser input[type="checkbox"]:checked');
      all.forEach((CheckboxInputElement _){
        _.checked = false;
      });
      dataset['state'] = 'none';
    }
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
  
  
  void createSpreadsheetForPage(Event e){
    e.preventDefault();
    if(!isGoogleConnected) return;
    var dialog = query('#CreateSpreadsheetDialog');
    ModalManager.show(dialog).then((var res){
      
      var width = dialog.offsetWidth;
      var height = dialog.offsetHeight;
      
      var top = window.innerHeight/2 - height/2;
      var left = window.innerWidth/2 - width/2;
      
      dialog.style.top = '${top}px';
      dialog.style.left = '${left}px';
      
      StreamSubscription<MouseEvent> ev;
      ev = dialog.onClick.listen((Event e){
        Element el = e.target;
        if(el.dataset.containsKey('dismiss')){
          ModalManager.hide(dialog);
          ev.cancel();
        } else if(el.dataset.containsKey('accept')){
          InputElement ie = query('#SpreadsheetName');
          var value = ie.value;
          print(value);
          
          ModalManager.hide(dialog);
          ev.cancel();
        }
      });
    });
    
    
    
    return;
    //<id>https://spreadsheets.google.com/feeds/list/0Ajpy9PK_RiBOdDhfdjB2Mk1XbjFSZGNlQS00MUlkaHc/od6/private/full/1</id>
    var contentType = 'application/vnd.google-apps.spreadsheet';
    var base64Data = window.btoa('');
    var newFile = new drivelib.File.fromJson({"title": 'API test', "mimeType": contentType});
    drive.files.insert(newFile, content: base64Data, contentType: contentType)
      .then((data) {
        window.console.log(data);
        print(data['alternateLink']);
      })
      .catchError((e) {
        window.console.log(e);
      });
    
  }
  void selectSpreadsheetForPage(Event e){
    e.preventDefault();
    if(!isGoogleConnected) return;
    
  }
  
}


//Utility methods
void openDropdown(Event  e, String action){
  e.preventDefault();
  e.stopPropagation();
  
  Element dropdown;
  switch(action){
    case 'spreadsheet-actions': 
      dropdown = query('#SpreadsheetActions');
    break;
  }
  
  if(dropdown == null) return;
  dropdown.classes.remove('hidden');
  
  
  // close when user click on whatever
  StreamSubscription<MouseEvent> ev;
  ev = window.onClick.listen((Event e){
    
    Element el = e.target;
    var close = false;
    while(true){
      if(el.dataset.containsKey('data-action') && el.dataset['data-action'] == action){
        // click on myself.
        return;
      }
      if(el.tagName.toLowerCase() == 'body'){
        //close me, pls.
        close = true;
        break;
      }
      el = el.parent;
    }
    if(close){
      dropdown.classes.add('hidden');
      ev.cancel();
    }
  });
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
