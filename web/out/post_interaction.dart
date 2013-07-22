// Auto-generated from post_interaction.html.
// DO NOT EDIT.

library x_post_interaction;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import '_from_packages/widget/components/dropdown.dart';
import 'dart:html';
import 'package:web_ui/web_ui.dart';



/**
 * [PostInteraction] is a action bar related to posts.
 */
class PostInteraction extends WebComponent with Observable  {
  /** Autogenerated from the template. */

  autogenerated.ScopedCssMapper _css;

  /** This field is deprecated, use getShadowRoot instead. */
  get _root => getShadowRoot("x-post-interaction");
  static final __html1 = new autogenerated.Element.html('<div class="post-action-item">\n              <input type="button" data-state="none" class="list-action-button" value="Select all">\n            </div>'), __html10 = new autogenerated.Element.html('<li title="Use this sheed for reports">\n                          <a data-toggle="dropdown" data-action="replace-worksheet-for-page"></a>\n                        </li>'), __html11 = new autogenerated.Element.html('<input type="button" class="list-action-button" value="Log in to spreadsheet service">'), __html2 = new autogenerated.Element.html('<div class="post-action-item">\n              <input title="Add selected posts to spreadsheet" type="button" class="list-action-button " value="Add selected to spreadsheet">\n            </div>'), __html3 = new autogenerated.Element.html('<div is="x-dropdown">\n                  <a href="#" data-toggle="dropdown" class="list-action-button ">Attach spreadsheet<i data-toggle="dropdown" class="icon-chevron-down"></i></a>\n                  <ul class="dropdown-menu">\n                    <li><a data-toggle="dropdown" data-action="select-spreadsheet-for-page">Select</a></li>\n                    <li><a data-toggle="dropdown" data-action="create-spreadsheet-for-page">Create</a></li>\n                  </ul>\n                </div>'), __html4 = new autogenerated.Element.html('<div is="x-dropdown" class="attachedSpreadsheetActions">\n                  <a href="#" data-toggle="dropdown" class="list-action-button "></a>\n                  <ul class="dropdown-menu">\n                    <li title="Remove association of this spredsheet to Facebook page">\n                      <a data-toggle="dropdown" data-action="detach-spreadsheet-from-page">Detach sheet</a>\n                    </li>\n                    <li title="Add new worksheet to selected spreadsheet">\n                      <a data-toggle="dropdown" data-action="add-worksheet-to-page">Add new worksheet</a>\n                    </li>\n                    <li>\n                      <a target="_blank">Open in new tab</a>\n                    </li>\n                    <template></template>\n                    <template></template>\n                  </ul>\n                </div>'), __html5 = new autogenerated.Element.html('<i data-toggle="dropdown" class="icon-chevron-down"></i>'), __html6 = new autogenerated.Element.html('<span data-toggle="dropdown" class="spreadsheet-title-action-label"></span>'), __html7 = new autogenerated.Element.html('<li class="dropdown-loading">\n                        loading....\n                      </li>'), __html8 = new autogenerated.Element.html('<li class="divider"></li>'), __html9 = new autogenerated.Element.tag('template'), __shadowTemplate = new autogenerated.DocumentFragment.html('''
        <!-- Posts actions container -->
        <div class="row-fluid post-list-actions">
          <div class="wrapper flex-container">
            
            <template></template>
            
            <div data-action="spreadsheet-actions" class="post-action-item">
              <!-- has no spreadsheet attached -->
              <template></template>
              <!-- has spreadsheet attached -->
              <template></template>
            </div>
            <div class="post-action-item">
              
              <!-- Not logged in Google Service view -->
              <template></template>
              
            </div>
            <div class="post-action-item flex-auto-item">
              <a href="#" class="list-action-button"><i class="icon-chevron-left"></i>Back</a>
            </div>
          </div>
        </div>
       ''');
  autogenerated.AnchorElement __e83;
  autogenerated.Element __e64, __e67, __e80, __e82;
  autogenerated.Template __t;

  void created_autogenerated() {
    var __root = createShadowRoot("x-post-interaction");
    setScopedCss("x-post-interaction", new autogenerated.ScopedCssMapper({"x-post-interaction":"[is=\"x-post-interaction\"]"}));
    _css = getScopedCss("x-post-interaction");
    __t = new autogenerated.Template(__root);
    __root.nodes.add(__shadowTemplate.clone(true));
    __e64 = __root.nodes[3].nodes[1].nodes[1];
    __t.conditional(__e64, () => inlist, (__t) {
      var __e60, __e61, __e62, __e63;
      __e61 = __html1.clone(true);
      __e60 = __e61.nodes[1];
      __t.listen(__e60.onClick, ($event) { toggleSelection($event); });
      __e63 = __html2.clone(true);
      __e62 = __e63.nodes[1];
      __t.listen(__e62.onClick, ($event) { postSelection($event); });
      __t.bindClass(__e62, () => googleActionButtonsClass, false);
    __t.addAll([new autogenerated.Text('\n            '),
        __e61,
        new autogenerated.Text('\n            \n            '),
        __e63,
        new autogenerated.Text('\n            ')]);
    });

    __e67 = __root.nodes[3].nodes[1].nodes[3].nodes[3];
    __t.conditional(__e67, () => fbi.currentPageConfig == null || fbi.currentPageConfig.sheetId == null, (__t) {
      var __e65, __e66;
      __e66 = __html3.clone(true);
      __e65 = __e66.nodes[1];
      __t.bindClass(__e65, () => googleActionButtonsClass, false);
      __t.listen(__e66.onClick, ($event) { dropdownClickCallback($event); });
      __t.component(new Dropdown()..host = __e66);
    __t.addAll([new autogenerated.Text('\n                '),
        __e66,
        new autogenerated.Text('\n              ')]);
    });

    __e80 = __root.nodes[3].nodes[1].nodes[3].nodes[7];
    __t.conditional(__e80, () => fbi.currentPageConfig != null && fbi.currentPageConfig.sheetId != null, (__t) {
      var __e69, __e71, __e72, __e73, __e78, __e79;
      __e79 = __html4.clone(true);
      __e71 = __e79.nodes[1];
      __e69 = __html6.clone(true);
      var __binding68 = __t.contentBind(() => fbi.currentPageConfig.spreadsheetTitle, false);
      __e69.nodes.add(__binding68);
      var __binding70 = __t.contentBind(() => fbi.currentPageConfig.sheetTitle, false);
      __e71.nodes.addAll([new autogenerated.Text('\n                    '),
          __e69,
          new autogenerated.Text(' '),
          __binding70,
          __html5.clone(true),
          new autogenerated.Text('\n                  ')]);
      __t.bindClass(__e71, () => googleActionButtonsClass, false);
      __e72 = __e79.nodes[3].nodes[5].nodes[1];
      __t.bind(() => fbi.currentPageConfig.fileId,  (__e) { __e72.href = autogenerated.sanitizeUri('https://docs.google.com/spreadsheet/ccc?key=${__e.newValue}'); }, false);
      __e73 = __e79.nodes[3].nodes[7];
      __t.conditional(__e73, () => fbi.spreadsheetSheetsListLoading, (__t) {
      __t.addAll([new autogenerated.Text('\n                      '),
          __html7.clone(true),
          new autogenerated.Text('\n                    ')]);
      });

      __e78 = __e79.nodes[3].nodes[9];
      __t.conditional(__e78, () => fbi.spreadsheetSheetsList[fbi.currentPageConfig.fileId] != null, (__t) {
        var __e77;
        __e77 = __html9.clone(true);
        __t.loop(__e77, () => fbi.spreadsheetSheetsList[fbi.currentPageConfig.fileId], ($list, $index, __t) {
          var sheetInfo = $list[$index];
          var __e75, __e76;
          __e76 = __html10.clone(true);
          __e75 = __e76.nodes[1];
          var __binding74 = __t.contentBind(() => sheetInfo.title, false);
          __e75.nodes.add(__binding74);
          __t.oneWayBind(() => sheetInfo.id, (e) { if (__e75.dataset['params'] != e) __e75.dataset['params'] = e; }, false, false);
        __t.addAll([new autogenerated.Text('\n                        '),
            __e76,
            new autogenerated.Text('\n                      ')]);
        });
      __t.addAll([new autogenerated.Text('\n                      '),
          __html8.clone(true),
          new autogenerated.Text('\n                      '),
          __e77,
          new autogenerated.Text('\n                    ')]);
      });

      __t.listen(__e79.onClick, ($event) { dropdownClickCallback($event); });
      __t.component(new Dropdown()..host = __e79);
    __t.addAll([new autogenerated.Text('\n                '),
        __e79,
        new autogenerated.Text('\n              ')]);
    });

    __e82 = __root.nodes[3].nodes[1].nodes[5].nodes[3];
    __t.conditional(__e82, () => !fbi.isGoogleConnected, (__t) {
      var __e81;
      __e81 = __html11.clone(true);
      __t.listen(__e81.onClick, ($event) { fbi.googleLogin(); });
    __t.addAll([new autogenerated.Text('\n                '),
        __e81,
        new autogenerated.Text('\n              ')]);
    });

    __e83 = __root.nodes[3].nodes[1].nodes[7].nodes[1];
    __t.listen(__e83.onClick, ($event) { backAction($event); });
    __t.create();
  }

  void inserted_autogenerated() {
    __t.insert();
  }

  void removed_autogenerated() {
    __t.remove();
    __t = __e64 = __e67 = __e80 = __e82 = __e83 = null;
  }

  /** Original code from the component. */

  dynamic __$fbi;
  dynamic get fbi {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'fbi');
    }
    return __$fbi;
  }
  set fbi(dynamic value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'fbi',
          __$fbi, value);
    }
    __$fbi = value;
  }
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
//# sourceMappingURL=post_interaction.dart.map