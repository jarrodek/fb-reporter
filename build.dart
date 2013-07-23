import 'dart:io';
import 'package:web_ui/component_build.dart';

// Ref: http://www.dartlang.org/articles/dart-web-components/tools.html
main() {
  //build(new Options().arguments, ['web/fbreporter.html']);
  
  List<String> args = new Options().arguments;
  bool fullRebuild = false;

  for (String arg in args) {
    if (arg.startsWith('--changed=') && arg.endsWith('.css')) {
      fullRebuild = true;
    }
  }

  if(fullRebuild) {
    build(['--machine', '--full'], ['web/fbreporter.html']);
  } else {
    build(args, ['web/fbreporter.html']);
  }
}
