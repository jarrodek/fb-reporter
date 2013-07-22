import 'dart:html';
import 'dart:async';
import 'dart:collection';

import 'package:web_ui/web_ui.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl_browser.dart';
import 'package:intl/intl.dart';

class DateRange extends WebComponent{
  ///Applied selection end
  @observable DateTime selectionend;
  ///Applied selection start
  @observable DateTime selectionstart;
  
  
  @observable bool initialized = false;
  @observable bool showing = false;
  ///Value to be displayed in display
  String get displayValue {
    if(selectionstart == null){
      //Must have selection start
      return "Select date range";
    }
    String start = _dateFormat.format(selectionstart);
    String end;
    if(selectionend == null){
      end = start;
    } else {
      end = _dateFormat.format(selectionend);
    }
    return "$start - $end";
  }
  
  /// Display date format
  @observable DateFormat _dateFormat = new DateFormat.yMd();
  /// Current locale
  @observable String _locale;
  String get locale => _locale;
  set locale(String l){
    _locale = l;
    initializeDateFormatting(_locale, null)
      .then((_) => _initializeTexts(new DateFormat.E(l).dateSymbols))
      .then((_) => _dateFormat = new DateFormat.yMd(l));
  }
  
  int firstDayOfWeek;
  @observable static List<String> monthTexts = toObservable([]);
  @observable static List<String> weekdayTexts = toObservable([]);
  set format(String f) => new DateFormat(f,locale);
  
  /// Currently selected (but not accepted) start day
  @observable DateTime currentSelectedStart;
  ///String value for selected date start
  String _startDateInput;
  /// Fetter for selected date start.
  /// If [_startDateInput] is null, then [currentSelectedStart] will be taken to format date.
  String get startDateInput => _startDateInput == null ? currentSelectedStart == null ? '' : _dateFormat.format(currentSelectedStart) : _startDateInput;
  /// Currently selected (but not accepted) end day
  @observable DateTime currentSelectedEnd;
  @observable String _endDateInput;
  @observable String get endDateInput => _endDateInput == null ? currentSelectedEnd == null ? '' : _dateFormat.format(currentSelectedEnd) : _endDateInput;
  
  /// Visible calendars start date
  @observable DateTime calendarStartDate = new DateTime.now();
  /// True if user has it's own custom range and false if the user used preseleced values.
  @observable bool isCustomSelection = true;
  String get inputRangeCss => isCustomSelection ? '' : ' disabled';
  
  set startDateInput(String v){
    try{
      DateTime _try = _dateFormat.parse(v);
      
      if(limitright != null){
        DateTime compare = new DateTime(limitright.year,limitright.month, limitright.day);
        if(_try.isAfter(compare)){
          currentSelectedStart = compare;
          _startDateInput = _dateFormat.format(compare);
          return;
        }
      }
      if(limitleft != null){
        DateTime compare = new DateTime(limitleft.year, limitleft.month, limitleft.day);
        if(_try.isBefore(compare)){
          currentSelectedStart = compare;
          _startDateInput = _dateFormat.format(compare);
          return;
        }
      }
      
      
      currentSelectedStart = _try;
      _startDateInput = v;
      calendarStartDate = new DateTime(currentSelectedStart.year, currentSelectedStart.month+2,currentSelectedStart.day);
    }catch(e){
      print('Formated string: $v, locale: $locale');
      print(e);
    }
  }
  set endDateInput(String v){
    try{
      DateTime _try = _dateFormat.parse(v);
      if(limitright != null){
        DateTime compare = new DateTime(limitright.year,limitright.month, limitright.day);
        if(_try.isAfter(compare)){
          currentSelectedEnd = compare;
          _endDateInput = _dateFormat.format(compare);
          return;
        }
      }
      if(limitleft != null){
        DateTime compare = new DateTime(limitleft.year, limitleft.month, limitleft.day);
        if(_try.isBefore(compare)){
          currentSelectedEnd = compare;
          _endDateInput = _dateFormat.format(compare);
          return;
        }
      }
      currentSelectedEnd = _try;
      _endDateInput = v;
      //
      calendarStartDate = currentSelectedEnd;
    }catch(e){
      print('Formated string: $v, locale: $locale');
      print(e);
    }
  }
  
  /// Limit selector to dates before [limitright] date (exclusive).
  DateTime limitright;
  /// Limit selector to dates after [limitleft] date (exclusive).
  DateTime limitleft;
  
  int calendars = 3;
  @observable List<AppCalendar> get  calendarsList => _calendarsData();
  
  
  List<AppCalendar> _calendarsData(){
    if(!initialized) return [];
    
    List<AppCalendar> result = [];
    
    if(calendars > 3){
      calendars = 3;
    }
    
    
    int m = calendarStartDate.month;
    int y = calendarStartDate.year;
    
    m -= (calendars-1);
    if(m < 1){ //months are [1-12] based
      m = 12 + m; //m is only 0 to -11
      y--;
    }
    DateTime startDate = new DateTime(y, m, 1);
    
    for(int i=0; i<calendars; i++){
      int y = startDate.year;
      int m = startDate.month;
      m += i;
      if(m==13){
        m = 1;
        y++;
      }
      DateTime _date = new DateTime(y, m, 1);
      AppCalendar cal = _generateCalendar(_date);
      cal.calendarNo = i;
      result.add(cal);
    }
    
    return result;
  }
  
  AppCalendar _generateCalendar(DateTime date){
    
    AppCalendar calendar = new AppCalendar();
    List calendarList = [];
    
    DateTime first = new DateTime(date.year,date.month,1);
    DateTime last = new DateTime(date.year,date.month+1,1).subtract(new Duration(days:1));
     
    List<int> weekList = [null,null,null,null,null,null,null];
    int pos = first.weekday - firstDayOfWeek;
    if(pos >= 7)
      pos -= 7;
    if(pos < 0)
      pos += 7;
    for(int i=1; i<=last.day; i++){
      weekList[pos] = i;
      pos++;
      if(pos >= 7){
        calendarList.add(weekList);
        weekList = [null,null,null,null,null,null,null];
        pos = 0;
      }
    }
    if(pos > 0){
      calendarList.add(weekList);
    }
    
    calendar.dates = calendarList;
    calendar.monthName = monthTexts[date.month-1];
    calendar.year = date.year;
    
    calendar.month = date.month;
    if(limitleft != null){
      if(date.year <= limitleft.year && date.month <= limitleft.month){
        calendar.limitLeft = limitleft;
      }
    }
    if(limitright != null){
      bool setLimit = false;
      if(date.year > limitright.year){
        setLimit = true;
      } else if(date.year == limitright.year){
        if(date.month >= limitright.month){
          setLimit = true;
        }
      }
      if(setLimit){
        calendar.limitRight = limitright;
      }
    }
    if(limitleft != null){
      bool setLimit = false;
      if(date.year < limitleft.year){
        setLimit = true;
      } else if(date.year == limitleft.year){
        if(date.month <= limitleft.month){
          setLimit = true;
        }
      }
      if(setLimit){
        calendar.limitLeft = limitleft;
      }
    }
    return calendar;
  }
  
  void created(){
    currentSelectedStart = _getNow();
    currentSelectedEnd = currentSelectedStart;
    
    findSystemLocale()
      .then((_) => initializeDateFormatting(Intl.systemLocale, null))
      .then((_) => _dateFormat = new DateFormat.yMd(Intl.systemLocale))
      .then((_) => _initializeTexts(new DateFormat.E().dateSymbols));
  }
  
  void inserted(){
    if(selectionstart != null){
      currentSelectedStart = new DateTime(selectionstart.year, selectionstart.month, selectionstart.day);
      if(selectionend != null){
        currentSelectedEnd = new DateTime(selectionend.year, selectionend.month, selectionend.day);;
      } else {
        currentSelectedEnd = selectionstart;
      }
    }
  }
  
  Future _initializeTexts(DateSymbols ds){
    //print("Initialize text layer: $ds");
    firstDayOfWeek = ds.FIRSTDAYOFWEEK;
    //print("The first day of week is: $firstDayOfWeek");
    weekdayTexts.clear();
    for(int i=1; i<=7; i++){
      int k = firstDayOfWeek+i;
      if(k>=7)
        k = k - 7;
      weekdayTexts.add(ds.NARROWWEEKDAYS[k]);
    }
    monthTexts = ds.STANDALONESHORTMONTHS;
    initialized = true;
    return new Future.value();
  }
  
  void previousMonth(){
    calendarStartDate = new DateTime(calendarStartDate.year, calendarStartDate.month-1, calendarStartDate.day);
  }
  
  void nextMonth(){
    calendarStartDate = new DateTime(calendarStartDate.year, calendarStartDate.month+1, calendarStartDate.day);
  }
  
  bool firstDaySelected = false;
  void selectDay(int year, int month, int day){
    DateTime d = new DateTime(year, month, day);
    setAsCustomSelection();
    
    if(firstDaySelected){
      // If new selection is earlier than [currentSelectedStart] then replace the dates.
      if(d.isBefore(currentSelectedStart)){
        currentSelectedStart = d;
        currentSelectedEnd = d;
        return;
      }
      
      currentSelectedEnd = d;
      firstDaySelected = false;
    } else {
      // select both start and end range as the same date.
      currentSelectedEnd = d;
      currentSelectedStart = d;
      firstDaySelected = true;
    }
  }
  
  bool isSelected(int year, int month, int day){
    DateTime current = new DateTime(year, month, day);
    if(currentSelectedStart == null){
      return false;
    }
    
    // Need to copy object or it can contain hours, minutes and seconds which cause vary results
    DateTime compare = new DateTime(currentSelectedStart.year,currentSelectedStart.month, currentSelectedStart.day);
    
    
    if(current.isAtSameMomentAs(compare)){
      return true;
    }
    
    if(current.isAfter(compare)){
      //check left bound
      if(currentSelectedEnd == null){
        return false;
      }
      DateTime compareEnd = new DateTime(currentSelectedEnd.year,currentSelectedEnd.month, currentSelectedEnd.day);
      if(current.isBefore(compareEnd) || current.isAtSameMomentAs(compareEnd)){
        return true;
      }
    }
    return false;
  }
  /// Set current selection as a result
  void apply(Event e){
    selectionstart = currentSelectedStart;
    selectionend = currentSelectedEnd;
    showing = false;
    
    
    
    Event ce = new Event.eventType('HTMLEvents','change');
    host.dispatchEvent(ce);
  }
  /// Cancel dialog
  void cancel(Event e){
    e.preventDefault();
    showing = false;
  }
  
  void show(Event e){
    e.preventDefault();
    showing = true;
  }
  
  void rangeInputsChange(Event e){
    e.preventDefault();
    e.stopPropagation();
  }
  
  void presetRange(Event e){
    e.preventDefault();
    e.stopPropagation();
    SelectElement target = e.target;
    List<OptionElement> items = target.selectedOptions;
    if(items.length == 0) return;
    OptionElement item = items.first;
    switch(item.value){
      case 'today': 
        currentSelectedStart = _getNow();
        currentSelectedEnd = currentSelectedStart;
        isCustomSelection = false;
        firstDaySelected = false;
      break;
      case 'yesterday': 
        currentSelectedStart = _getNow().subtract(new Duration(days:1));
        currentSelectedEnd = currentSelectedStart;
        isCustomSelection = false;
        firstDaySelected = false;
        break;
      case 'last-week':
        DateTime helper = _getNow();
        currentSelectedStart = helper.subtract(new Duration(days: (7 + helper.weekday))); //remove 7 days and day of the week number
        currentSelectedEnd = helper.subtract(new Duration(days: (1 + helper.weekday))); // remove day of the week and one day
        isCustomSelection = false;
        firstDaySelected = false;
        break;
      case 'last-month': 
        DateTime helper = _getNow();
        currentSelectedStart = new DateTime(helper.year,helper.month-1,1);
        currentSelectedEnd = new DateTime(helper.year,helper.month,1).subtract(new Duration(days:1));
        isCustomSelection = false;
        firstDaySelected = false;
        break;
      case 'custom': 
        //nothing
        isCustomSelection = true;
        firstDaySelected = false;
        break;
    }
  }
  
  void setAsCustomSelection(){
    isCustomSelection = true;
    Element el = query('#DrPresetOption');
    if(el == null) return;
    (el as SelectElement).selectedIndex = 0;
  }
  
  
  /// Get current day [DateTime] object without hours, minutes, seconds and so on. 
  DateTime _getNow(){
    DateTime helper = new DateTime.now();
    return new DateTime(helper.year,helper.month,helper.day);
  }
  
}


class AppCalendar {
  ///Debug.
  int calendarNo;
  List dates;
  String monthName;
  int year;
  int month;
  bool get hasLimit => limitRight != null || limitLeft != null;
  ///Right limit for date range (limit for dates after this day)
  DateTime limitRight;
  ///Left limit for date range (limit for dates before this day)
  DateTime limitLeft;
  
  /// Return true if day can be selected.
  bool isSelectable(int day){
    if(!hasLimit) return true;
    //is limited right (the day is after limit)
    if(limitRight != null){
      return !new DateTime(year, month, day).isAfter(limitRight);
    }
    //is limited left (the day is before limit)
    if(limitLeft != null){
      return !new DateTime(year, month, day).isBefore(limitLeft);
    }
    return true;
  }
}