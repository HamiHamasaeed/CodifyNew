import 'package:flutter/material.dart';

import '../models/sensors_model.dart';
import '../services/helper.dart';

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

  late Future<List<Sensors>> sensor;
  late Future<List<Sensors>> arduino;
  late Future<List<Sensors>> other;
  late Future<Sensors> product;

  void getSensorFromHelper() {
    sensor = Helper().getSensor();
  }

  void getArduinoFromHelper() {
    arduino = Helper().getArduino();
  }

  void getOthersFromHelper() {
    other = Helper().getOthers();
  }

  void getArduino(String category, String id) {
    if (category == "Arduino") {
      product = Helper().getArduinoByID(id);
    } else if (category == "Sensors") {
      product = Helper().getSensorByID(id);
    } else {
      product = Helper().getOthersByID(id);
    }
  }
}
