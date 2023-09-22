
import 'package:flutter/foundation.dart';

class NavigatorProvider with ChangeNotifier {
  double _value=0;
  double get value=> _value;

  void setSlider(double move){
    _value = move;
    notifyListeners();
  }
}