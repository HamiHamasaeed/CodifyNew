import 'package:flutter/services.dart' as the_bundle;
import 'package:codifyecommerce/models/sensors_model.dart';

class Helper {
  Future<List<Sensors>> getSensor() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/sensors.json");

    final sensorList = sensorsFromJson(data);

    return sensorList;
  }

  Future<List<Sensors>> getArduino() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/arduino.json");

    final arduinoList = sensorsFromJson(data);

    return arduinoList;
  }

  Future<List<Sensors>> getOthers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/others.json");

    final othersList = sensorsFromJson(data);

    return othersList;
  }

  Future<Sensors> getSensorByID(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/sensors.json");

    final sensorList = sensorsFromJson(data);

    final sensor = sensorList.firstWhere((sensor) => sensor.id == id);

    return sensor;
  }

  Future<Sensors> getArduinoByID(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/arduino.json");

    final arduinoList = sensorsFromJson(data);

    final arduino = arduinoList.firstWhere((arduino) => arduino.id == id);

    return arduino;
  }

  Future<Sensors> getOthersByID(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/others.json");

    final otherList = sensorsFromJson(data);

    final other = otherList.firstWhere((other) => other.id == id);

    return other;
  }
}
