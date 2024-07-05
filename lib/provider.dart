import 'package:flutter/material.dart';
import 'worker.dart';

class WeatherProvider extends ChangeNotifier {
  String city = 'Mumbai';
  String temp = 'Loading...';
  String airSpeed = 'Loading...';
  String description = 'Loading...';
  String humidity = 'Loading...';
  String icon = 'Loading...';

  Future<void> fetchData(String location) async {
    Worker instance = Worker(location: location);
    await instance.getData();
    temp = instance.temp;
    airSpeed = instance.airSpeed;
    description = instance.description;
    humidity = instance.humidity;
    icon = instance.icon;
    city = location;
    notifyListeners();
  }
}
