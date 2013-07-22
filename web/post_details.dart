import 'dart:html';
import 'dart:math' as Math;
import 'package:web_ui/web_ui.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/**
 * [FacebookPagePostInsight] represents a view for selected page post.
 */
class FacebookPostInsightView extends WebComponent {
  
  
  void created(){
    initializeDateFormatting(window.navigator.language, null).then((_){});
  }
  
  
  /// The controller
  var ctrl;
  /// [0] => [{}]
  /// [1] => [{post_id,created_time,message,type,permalink,description,attachment{media{href,alt,type,src}}}]
  get insights => ctrl.pagePostInsights;
  
  get postData => insights[1][0];
  get postPicture {
    try{
      var img = insights[1][0]['attachment']['media'][0]['photo']['images'][1];
      return {
        'src':img['src'],
        'width':img['width'].toString(),
        'height':img['height'].toString()
      };
    } catch(e){
      return null;
    }
  }
  
  get post_impressions_unique => (getMetricValue('post_impressions_unique') == null) ? 0 : getMetricValue('post_impressions_unique');
  get post_stories_by_action_type => getMetricValue('post_stories_by_action_type');
  get post_story_adds_by_action_type_unique => getMetricValue('post_story_adds_by_action_type_unique');
  get post_storytellers => (getMetricValue('post_storytellers') == null) ? 0 : getMetricValue('post_storytellers');
  
  String _created_time;
  ///Get formatted time string
  String get created_time { 
    if(_created_time == null){
      DateFormat df = new DateFormat.yMMMMd(window.navigator.language).add_Hm();
      _created_time = df.format(new DateTime.fromMillisecondsSinceEpoch(postData['created_time']*1000));
    }
    return _created_time;
  }
  
  double get virality {
    double res = post_storytellers/post_impressions_unique*100;
    int pow = Math.pow(10, 2);
    return (res*pow).round() / pow;
  }
  
  var _cache = {};
  getMetricValue(String insight_metric) {
    if(_cache[insight_metric] == null){
      var data = insights[0];
      var len = data.length;
      for(int i=0; i<len; i++){
        if(data[i]['metric'] == insight_metric){
          _cache[insight_metric] = data[i].value;
          break;
        }
      }
      if(_cache[insight_metric] == null){
        _cache[insight_metric] = false;
      }
    } else if(_cache[insight_metric] == false){
      return null;
    }
    return _cache[insight_metric];
  }
  
  
}