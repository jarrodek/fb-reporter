part of fbreporter;

class FB {
  
   
  static Future login([List scopes = null]){
    var completer = new Completer();
    
    void _handleFacebookLoginResponse(var response){
      if(response != null && response.status != ''){
        if(response.status == 'connected'){
          var ar = response.authResponse;
          var fbauth = new FacebookAuth(ar.accessToken, ar.expiresIn, ar.signedRequest, ar.userID);
          completer.complete(fbauth);
        } else {
          completer.complete(null);
        }
      } else {
        var ex = new Exception("Unable read response from Facebook.");
        completer.completeError(ex);
      }
    }
    
    js.context.fbloginhandler = new js.Callback.once(_handleFacebookLoginResponse);
    var options;
    if(scopes != null){
      options = js.map({'scope': scopes.join(',')});
    } else {
      options = null;
    }
    
    js.context.FB.login(js.context.fbloginhandler, options);
    
    return completer.future;
  }
  
  
  
  
  static Future getLoginStatus(){
    var completer = new Completer();
    
    void _handleFacebookLoginStatusResponse(var response){
      
      if(response != null && response.status != ''){
        if(response.status == 'connected'){
          var ar = response.authResponse;
          var fbauth = new FacebookAuth(ar.accessToken, ar.expiresIn, ar.signedRequest, ar.userID);
          completer.complete(fbauth);
        } else {
          completer.complete(null);
        }
      } else {
        var ex = new Exception("Unable read response from Facebook.");
        completer.completeError(ex);
      }
    }
      
    js.context.fbloginstatushandler = new js.Callback.once(_handleFacebookLoginStatusResponse);
    js.context.FB.getLoginStatus(js.context.fbloginstatushandler);
    return completer.future;
  }
  
  
  static Future api(String path, [Map params=null]){
    
    var completer = new Completer();
    
    void closureResponse(js.Proxy response){
      var t = js.retain(response);
      completer.complete(t);
    }
    
    String now = window.performance.now().toString();
    now = now.replaceAll(".", "_");
    
    String fnName = 'fbclb_$now';
    js.context[fnName] = new js.Callback.once(closureResponse);
    if(params != null){
      js.context.FB.api(path, js.map(params), js.context[fnName]);
    } else {
      try{
        js.context.FB.api(path, js.context[fnName]);
      } catch(e){
        completer.completeError(e);
      }
    }
    
    return completer.future;
  }
}

class FacebookAuth {
  String accessToken;
  int expiresIn;
  String signedRequest;
  String userID;
  FacebookAuth(this.accessToken,this.expiresIn, this.signedRequest, this.userID);
}


class FacebookPage {
  String category;
  String name;
  String access_token;
  String id;
  FacebookPage(this.category, this.name, this.access_token, this.id);
}