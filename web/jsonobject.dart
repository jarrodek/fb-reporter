part of fbreporter;

class JsonResponseObject {
  
  js.Proxy _objectData;
  
  JsonResponseObject(js.Proxy data) {
    _objectData = js.retain(data);
  }
  
  
  
  noSuchMethod(Invocation msg) {
    if(msg.isGetter){
      print("noSuchMethod: getter ${msg.namedArguments.length}");
      msg.namedArguments.forEach((var k, var v){
        print("params: ${k} => $v");
      });
    } else if(msg.isSetter) {
      print("noSuchMethod: setter");
    }
    
    
    /*
    if (args.length == 0 && function_name.startsWith("get:")) {
      //use the getter function name (such as get:name )
      //as the key
      var property = function_name.replaceFirst("get:", "");
      if (_objectData.containsKey(property)) {
        return _objectData[property];
      }
    } else if (args.length == 1 && function_name.startsWith("set:")) {
      //use the setter function mame (such as set:name )
      //as the key
      var property = function_name.replaceFirst("set:", "");
      if (_objectData.containsKey(property)) {
        _objectData[property] = args[0];
        return _objectData[property];
      }
    }
    
    // if we get here, then we've not found the key - throw.
    throw new NoSuchMethodException(this,function_name,args);
    */
  }
  
}