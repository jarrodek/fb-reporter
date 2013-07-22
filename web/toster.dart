part of fbreporter;

abstract class ToastBase {
  ///Show text notification for a short period of time. 
  ///This time could be user-definable. 
  static final int LENGTH_SHORT = 2000;
  ///Show text notification for a medium period of time. 
  ///This time could be user-definable. 
  static final int LENGTH_MEDIUM = 5000;
  ///Show text notification for a long period of time. 
  ///This time could be user-definable. 
  static final int LENGTH_LONG = 10000;
  ///Show text notification for a very long period of time. 
  ///This time could be user-definable. This is the default.
  static final int LENGTH_INFINITY = 999999999;
  
  List<ToastText> _messages = new List();
  Timer currentTimer;
  
  /// Make a [Toast].
  /// It must have [message] to display. If [duration] is set, the [Toast] 
  /// will be shown for set period of time. [isError] parameter determine 
  /// display type.
  void makeText(String message, [int duration=null, bool isError=false]){
    if(duration == null){
      duration = ToastBase.LENGTH_INFINITY;
    }
    ToastText msg = new ToastText();
    msg.message = message;
    msg.duration = duration;
    msg.isError = isError;
    _messages.add(msg);
  }
  
  void show(){
    if(_messages.length == 0){
      return;
    }
    if(currentTimer != null && currentTimer.isActive){
      return;
//      currentTimer.cancel();
//      dismissMessage();
    }
    
    ToastText msg = _messages.removeAt(0);
    DivElement wrapper = new DivElement();
    DivElement messageContainer = new DivElement();
    SpanElement messageWrapper = new SpanElement();
    DivElement dismissContainer = new DivElement();
    AnchorElement anchor = new AnchorElement();
    
    String errorClass = msg.isError ? " error" : "";
    
    anchor
      ..innerHtml = 'dismiss'
      ..classes.add('toast-dismiss')
      ..href = 'about:blank'
      ..onClick.listen((Event e) => dismissMessageHandler(e));
    dismissContainer
      ..append(anchor)
      ..classes.add('toast-dismiss-container');
    messageWrapper
      ..text = msg.message
      ..classes.add('toast-message');
    messageContainer
      ..append(messageWrapper)
      ..classes.add('toast-message-container');
    wrapper
      ..append(messageContainer)
      ..append(dismissContainer)
      ..classes.add('toast-wrapper$errorClass');
    getContainer()
      ..append(wrapper)
      ..classes.remove('hidden');
    currentTimer = new Timer(new Duration(milliseconds:msg.duration), () => dismissMessage());
  }
  
  void dismissMessage(){
    if(currentTimer != null && currentTimer.isActive){
      currentTimer.cancel();
    }
    
    Element container = getContainer();
    container.classes.add('hidden');
    container.children.clear();
    new Timer(new Duration(milliseconds:300), () => show());
  }
  void dismissMessageHandler(Event e){
    e.preventDefault();
    dismissMessage();
  }
  
  /// Returns message container where message will be put.
  /// It will contain two elements: mesage container
  /// and dismiss button.
  /// This method must return the same element each time it called.
  Element getContainer();
}

class Toast extends ToastBase {
  ///Show text notification for a short period of time. 
  ///This time could be user-definable. 
  static final int LENGTH_SHORT = 2000;
  ///Show text notification for a medium period of time. 
  ///This time could be user-definable. 
  static final int LENGTH_MEDIUM = 5000;
  ///Show text notification for a long period of time. 
  ///This time could be user-definable. 
  static final int LENGTH_LONG = 10000;
  ///Show text notification for a very long period of time. 
  ///This time could be user-definable. This is the default.
  static final int LENGTH_INFINITY = 999999999;
  
  static Toast _inst;
  Toast._internal();
  
  Element getContainer(){
    return query('#toaster');
  }
  
  factory Toast.makeText(String message, [int duration=null, bool isError=false]){
    if(_inst == null){
      _inst = new Toast._internal();
    }
    _inst.makeText(message, duration, isError);
    return _inst;
  }
}


class ToastText{
  String message;
  int duration;
  bool isError = false;
}