import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _arduinoSize = [];
  List<String> _sizes = [];
  int get activePage => _activePage;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners(); 
  }

  List<dynamic> get arduinoSize => _arduinoSize;
  set arduinoSize(List<dynamic> newArduino) {
    _arduinoSize = newArduino;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _arduinoSize.length; i++) {
      if (i == index) {
        _arduinoSize[i]['isSelected'] = !_arduinoSize[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }
}
