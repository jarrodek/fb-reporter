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
          FacebookAuth fbauth = new FacebookAuth(ar.accessToken, ar.expiresIn, ar.signedRequest, ar.userID);
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
    
    String now = window.performance.now().toString();
    now = now.replaceAll(".", "_");
    String fnName = 'fbclb_$now';
    
    
    void closureResponse(js.Proxy response){
      var t = js.retain(response);
      completer.complete(t);
      js.context[fnName] = null;
    }
    
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
  
  
  static Future<List> downloadInsights(Fql fql){

    var completer = new Completer();
    String now = window.performance.now().toString();
    now = now.replaceAll(".", "_");
    String fnName = 'fbclb_$now';
    
    void closureResponse(js.Proxy response){
      var t = js.retain(response);
      try{
        List insightsData = _parseInsights(fql, t);
        completer.complete(insightsData);
      }catch(e){
        completer.completeError(e);
      } finally {
        js.context[fnName] = null;
        js.release(t);
      }
    }
    
    var encodedQuery = fql.buildQuery();
    js.context[fnName] = new js.Callback.once(closureResponse);
    js.context.FB.api('/fql?q=$encodedQuery', js.context[fnName]);
    return completer.future;
  }
  
  static Future<List<FacebookPagePostInsight>> downloadDefaultInsights(List<String> postsList){
    var completer = new Completer();
    String query1 = 'SELECT object_id,metric,value FROM insights WHERE period = 0 and metric IN ("post_impressions_unique","post_stories_by_action_type","post_story_adds_by_action_type_unique","post_storytellers") and object_id IN("';
    query1 += postsList.join('","');
    query1 += '")';
    var query = {
      "query1": query1,
      "query2": 'SELECT post_id,created_time,message,type,attachment.media,attachment.fb_object_type,attachment.icon,permalink,description FROM stream WHERE post_id IN (SELECT object_id FROM #query1)'
    };
    
    String now = window.performance.now().toString();
    now = now.replaceAll(".", "_");
    String fnName = 'fbclb_$now';
    
    void closureResponse(js.Proxy response){
      var t = js.retain(response);
      try{
        List<FacebookPagePostInsight> insightsData = _parseDefaultInsights(t);
        completer.complete(insightsData);
      }catch(e){
        completer.completeError(e);
      } finally {
        js.context[fnName] = null;
        js.release(t);
      }
    }
    var encodedQuery = Uri.encodeComponent(JSON.stringify(query));
    js.context[fnName] = new js.Callback.once(closureResponse);
    js.context.FB.api('/fql?q=$encodedQuery', js.context[fnName]);
    return completer.future;
  }
  
  static List _parseInsights(Fql fql, js.Proxy proxy){
    var data = proxy['data'];
    if(data == null) return null;
    
    int dataLength = fql.length;
    
    if(data.length != dataLength) return null;
    List result = [];
    
    for(int i=0; i<dataLength; i++){
      FqlQuery query = fql[i];
      var fql_result_set = data[i]["fql_result_set"];
      int datasize = fql_result_set.length;
      List queryResult = []; 
      for(int j=0; j<datasize; j++){
        queryResult.add(js.retain(fql_result_set[j]));
      }
      result.add(queryResult);
    }
    return result;
  }
  static List<FacebookPagePostInsight> _parseDefaultInsights(js.Proxy proxy){
    var data = proxy['data'];
    if(data == null) return null;
    if(data.length != 2) return null;
    var q1 = data[0]['fql_result_set'];
    var q2 = data[1]['fql_result_set'];
    
    Map<String, FacebookPagePostInsight> _result = {};
    
    var l1 = q1.length;
    for(int i=0; i<l1;i++){
      var metric = q1[i];
      var postId = metric['object_id'];
      
      FacebookPagePostInsight ins;
      if(_result.containsKey(postId)){
        ins = _result[postId];
      } else {
        ins = new FacebookPagePostInsight();
        ins.postId = postId;
      }
      String metricName = metric['metric'];
      switch(metricName){
        case 'post_impressions_unique': ins.post_impressions_unique = metric['value']; break;
        case 'post_stories_by_action_type': 
          FacebookPagePostStoryByAction sba = new FacebookPagePostStoryByAction();
          sba.like = metric['value']['like'];
          sba.comment = metric['value']['comment'];
          sba.share = metric['value']['share'];
          ins.post_stories_by_action_type = sba;
        break;
        case 'post_story_adds_by_action_type_unique': 
          FacebookPagePostStoryByAction sba = new FacebookPagePostStoryByAction();
          sba.like = metric['value']['like'];
          sba.comment = metric['value']['comment'];
          sba.share = metric['value']['share'];
          ins.post_story_adds_by_action_type_unique = sba;
          break;
        case 'post_storytellers': ins.post_storytellers = metric['value']; break;
      }
      _result[postId] = ins;
    }
    
    
    var l2 = q2.length;
    for(int i=0; i<l2;i++){
      var post = q2[i];
      var postId = post['post_id'];
      FacebookPagePostInsight ins;
      if(_result.containsKey(postId)){
        ins = _result[postId];
      } else {
        ins = new FacebookPagePostInsight();
      }
      ins.postId = postId;
      ins.created_time = post['created_time'];
      ins.message = post['message'];
      ins.type = post['type'];
      ins.permalink = post['permalink'];
      ins.description = post['description'];
      
      var attachment = post['attachment'];
      FacebookPagePostAttachment att = new FacebookPagePostAttachment();
      att.icon = attachment['icon'];
      var media = attachment['media'];
      if(media != null){
        att.media = new List();
        var mediaLength = media.length;
        for(int j=0; j<mediaLength;j++){
          FacebookPagePostMedia fpm = new FacebookPagePostMedia();
          var mediaData = media[j];
          fpm.href = mediaData['href'];
          fpm.type = mediaData['type'];
          fpm.src = mediaData['src'];
          att.media.add(fpm);
        }
      }
      ins.attachment = att;
      _result[postId] = ins;
    }
    
    
    
    Iterable<FacebookPagePostInsight> values = _result.values;
    Iterator<FacebookPagePostInsight> it = values.iterator;
    List<FacebookPagePostInsight> result = new List();
    while(it.moveNext()){
      result.add(it.current);
    }
    return result;
  }
  
}


class FacebookPagePostInsight {
  /// The post ID
  String postId;
  ///The time the post was published, expressed as UNIX timestamp
  String _created_time;
  ///Set [timestamp] the post was published, expressed as UNIX timestamp
  set created_time(timestamp) {
    DateFormat df = new DateFormat.yMMMMd(window.navigator.language).add_Hm();
    this._created_time = df.format(new DateTime.fromMillisecondsSinceEpoch(timestamp*1000));
  }
  ///Get formatted time string
  String get created_time => _created_time;
  ///The message written in the post
  String message;
  /// The type of this story. Possible values are:
  /// 11 - Group created
  /// 12 - Event created
  /// 46 - Status update
  /// 56 - Post on wall from another user
  /// 66 - Note created
  /// 80 - Link posted
  /// 128 -Video posted
  /// 247 - Photos posted
  /// 237 - App story
  /// 257 - Comment created
  /// 272 - App story
  /// 285 - Checkin to a place
  /// 308 - Post in Group
  int type;
  /// An array of information about the attachment to the post
  FacebookPagePostAttachment attachment;
  ///The URL of the post
  String permalink;
  /// Text of stories not intentionally generated by users, such as those generated when two users become friends. You must have the "Include recent activity stories" migration enabled in your app to retrieve this field
  String description;
  ///The number of people who saw your Page post
  int post_impressions_unique;
  ///The number of stories created about your Page post, by action type
  FacebookPagePostStoryByAction post_stories_by_action_type;
  FacebookPagePostStoryByAction post_story_adds_by_action_type_unique;
  ///The number of unique people who created a story about your Page post ("People Talking About This" / PTAT)
  int post_storytellers;
  /// Calculate post virality 
  double get virality {
    if(post_storytellers == null) post_storytellers = 0;
    if(post_impressions_unique == null) post_impressions_unique = 0;
    double res = post_storytellers/post_impressions_unique*100;
    int pow = Math.pow(10, 2);
    return (res*pow).round() / pow;
  }
  
  /// Indicate if the post was sent to spreadsheet.
  bool isSent = false;
  /// Indicate if the post was sent to spreadsheet but it returns an error.
  bool isSentError = false;
  /// If present, error response from server
  String errorMessage;
  
  
  
  String get defaultPayload {
    String _attachment = "";
    String _attachmentHref = "";
    String _postPicture;
    
    if(attachment != null && attachment.media != null && attachment.media.length > 0){
      if(attachment.media[0].src != null){
        _postPicture = attachment.media[0].src;
      }
      if(attachment.media[0].href != null){
        _attachmentHref = attachment.media[0].href;
      }
    }
    
    if(type == 247){
      if(_postPicture != null && _postPicture.isNotEmpty){
        _attachment = "=image(\"" + imageProxy(_postPicture) + "\")";
      }
    } else if(type == 128) {
      _attachment = _attachmentHref;
    } else if(type == 80){
      if(_postPicture != null && _postPicture.isNotEmpty){
        _attachment = "=image(\""+imageProxy(_postPicture)+"\")";
      } else {
        _attachment = _attachmentHref;
      }
    }
    
    if(post_stories_by_action_type == null){
      post_stories_by_action_type = new FacebookPagePostStoryByAction();
    }
    if(post_story_adds_by_action_type_unique == null){
      post_story_adds_by_action_type_unique = new FacebookPagePostStoryByAction();
    }
    
    String payload = '<entry xmlns="http://www.w3.org/2005/Atom"\n\txmlns:gsx="http://schemas.google.com/spreadsheets/2006/extended">';
    payload += '<gsx:data><![CDATA[${created_time}]]></gsx:data>\n';
    payload += '<gsx:entry><![CDATA[${message}]]></gsx:entry>\n';
    payload += '<gsx:attachment><![CDATA[$_attachment]]></gsx:attachment>\n';
    payload += '<gsx:likes><![CDATA[${post_stories_by_action_type.like}]]></gsx:likes>\n';
    payload += '<gsx:uniquelikes><![CDATA[${post_story_adds_by_action_type_unique.like}]]></gsx:uniquelikes>\n';
    payload += '<gsx:comment><![CDATA[${post_stories_by_action_type.comment}]]></gsx:comment>\n';
    payload += '<gsx:uniquecomment><![CDATA[${post_story_adds_by_action_type_unique.comment}]]></gsx:uniquecomment>\n';
    payload += '<gsx:shares><![CDATA[${post_stories_by_action_type.share}]]></gsx:shares>\n';
    payload += '<gsx:uniqueshares><![CDATA[${post_story_adds_by_action_type_unique.share}]]></gsx:uniqueshares>\n';
    payload += '<gsx:virality><![CDATA[${virality}%]]></gsx:virality>\n';
    payload += '<gsx:talkingaboutthis><![CDATA[${post_storytellers}]]></gsx:talkingaboutthis>\n';
    payload += '<gsx:range><![CDATA[${post_impressions_unique}]]></gsx:range>\n';
    payload += '</entry>';
    return payload;
  }
  
  /**
   * Change image URL to url with proxy.
   * @param url The oryginal URL.
   * @return New URL with proxy.
   */
  static String imageProxy(String url){
    //https://images.weserv.nl/?url=ssl:www.google.com/logos/logo.gif
    //https://images.weserv.nl/?url=www.google.com/logos/logo.gif
    String proxy = "https://images.weserv.nl/?url=";
    String result = url;
    if(url.startsWith("http:")){
      String _url = url.replaceAll("http://", "");
      _url= Uri.encodeComponent(_url);
      result = proxy + _url;
    } else if(url.startsWith("https:")){
      String _url = url.replaceAll("https://", "");
      _url= Uri.encodeComponent(_url);
      result = proxy + "ssl:" + _url;
    }
    return result;
  }
  
  
  
  
  String toString(){
    StringBuffer sb = new StringBuffer();
    sb
      ..write("FacebookPagePostInsight=[")
      ..write("postId: ")
      ..write(postId)
      ..write(", ")
      ..write("created_time: ")
      ..write(created_time)
      ..write(", ")
      ..write("message: ")
      ..write(message)
      ..write(", ")
      ..write("type: ")
      ..write(type)
      ..write(", ")
      ..write("attachment: ")
      ..write(attachment)
      ..write(", ")
      ..write("permalink: ")
      ..write(permalink)
      ..write("]");
    return sb.toString();
  }
}

class FacebookPagePostStoryByAction {
  int _like;
  int _comment;
  int _share;
  
  set like(int value) => this._like = (value == null ? 0 : value);
  set comment(int value) => this._comment = (value == null ? 0 : value);
  set share(int value) => this._share = (value == null ? 0 : value);
  
  int get like => this._like == null ? 0 : this._like;
  int get comment => this._comment == null ? 0 : this._comment;
  int get share => this._share == null ? 0 : this._share;
}

class FacebookPagePostAttachment {
  List<FacebookPagePostMedia> media;
  String icon;
  
  String toString(){
    StringBuffer sb = new StringBuffer();
    sb
    ..write("FacebookPagePostAttachment=[")
      ..write("icon: ")
      ..write(icon)
      ..write(", ")
      ..write("media: ")
      ..write(media)
      ..write("], ");
    return sb.toString();
  }
}
class FacebookPagePostMedia {
  String href;
  String type;
  String src;
  String toString(){
    StringBuffer sb = new StringBuffer();
    sb
      ..write("FacebookPagePostMedia=[")
      ..write("href: ")
      ..write(href)
      ..write(", ")
      ..write("type: ")
      ..write(type)
      ..write(", ")
      ..write("src: ")
      ..write(src)
      ..write("], ");
    return sb.toString();
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


class Fql {
  List<FqlQuery> _query = new List();
  void append(FqlQuery query) => _query.add(query);
  int get length => _query.length;
  
  FqlQuery operator [](int i) => _query.elementAt(i);
  
  String buildQuery() {
    var builder = {};
    int i = 1;
    _query.forEach((FqlQuery q){
      builder["query$i"] = q.buildQuery();
      i++;
    });
    return Uri.encodeComponent(JSON.stringify(builder));
  }
}


class FqlQuery{
  List<String> metrics = new List();
  /// get metric at position [i]
  String operator [](int i) => metrics.elementAt(i);
  
  String table;
  HashMap<String, String> _conditions = new HashMap();
  /// [column] is some_colum_name, [condition] any valid sql condition e.g. "IN (id1,id1)" or '= "post"'
  String addCondition(String column, String condition) => _conditions[column] = condition;
  String buildQuery() {
    String q = "";
    q += "SELECT ";
    q += metrics.join(',');
    q += " FROM ";
    q += "$table";
    q += " WHERE ";
    
    _conditions.forEach((String k, String v){
      q += "$k $v AND ";
    });
    q = q.substring(0, q.length - 5);
    return q;
  }
}