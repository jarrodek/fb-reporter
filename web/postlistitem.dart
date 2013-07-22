import 'dart:html';
import 'package:web_ui/web_ui.dart';

class FacebookPostListItemComponent extends WebComponent {
  var post;
  @observable var ctrl;
  @observable bool selection = false;
  @observable String get containerClass => selection ? 'selected' : '';
  
  String get pageNameClass => ctrl.postSelectedMode ? 'span8' : 'span7';
  String get postimageClass => ctrl.postSelectedMode ? 'span3' : 'span1';
  
  void changeSelection(Event e){
    if((e.target as Element).localName.toLowerCase() == "input"){
      return;
    }
    //inform controler
    if(ctrl == null) return;
    ctrl.select(post['id'], !selection);
  }
}