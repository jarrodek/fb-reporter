import 'dart:html';
import 'package:web_ui/web_ui.dart';

/**
 * [PostInteraction] is a action bar related to posts.
 */
class PostInteraction extends WebComponent {
  @observable var fbi;
  bool inlist = true;
  String get googleActionButtonsClass => fbi.isGoogleConnected ? '' : 'disabled';
  
  void dropdownClickCallback(Event e){
    
    if((e.currentTarget as Element).classes.contains('attachedSpreadsheetActions')){
      if(!fbi.spreadsheetSheetsList.containsKey(fbi.currentPageConfig.fileId)){
        fbi.updateWorksheetListInActionMenu();
      }
    }
    
    Element el = e.target;
    if(el.dataset['action'] == null) {
      if(el.attributes['href'] == "#"){
        e.preventDefault();
      }
      return;
    }
    
    var params = el.dataset['params'];
    fbi.performExternalAction(el.dataset['action'], params);
  }
  
  void toggleSelection(Event e){
    e.preventDefault();
    bool selection = false;
    Element target = e.target;
    var dataset = target.dataset;
    if(dataset['state'] == 'all'){
      dataset['state'] = 'none';
    } else {
      dataset['state'] = 'all';
      selection = true;
    }
    
    
    String query = '#PostChooser [is="x-facebook-post-list-item"]';
    ElementList all = queryAll(query);
    all.forEach((Element _){
      if(_.xtag == null) return;
      _.xtag.selection = selection;
    });
    
  }
  void postSelection(Event e){
    e.preventDefault();
    if(!fbi.isGoogleConnected){
      return;
    }
    fbi.addSelectionToWorksheet();
  }
  
  void backAction(Event e){
    e.preventDefault();
    fbi.performBackAction();
  }
}