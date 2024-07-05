import 'package:http/http.dart' as http;
import 'dart:convert';

class Worker {
  Worker({required this.location});

  final String location;
  late String temp;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;
  late String icon;

  Future<void> getData() async {
    try {
      String urlString = "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=YOUR_API_KEY";
      Uri uri = Uri.parse(urlString);

      http.Response response = await http.get(uri);
      Map data = jsonDecode(response.body);

      // Getting temperature, humidity
      Map tempData = data['main'];
      String getHumidity = tempData['humidity'].toString();
      double getTemp = tempData["temp"];

      // Getting air speed
      Map wind = data['wind'];
      double getAirSpeed = wind['speed'];

      // Getting description
      List weatherData = data['weather'];
      Map weatherMainData = weatherData[0];
      String getMainDes = weatherMainData['main'];
      String getDesc = weatherMainData['description'];
      String getIcon = weatherMainData['icon'];

      // Assigning values
      getTemp = getTemp - 273.15; // Convert Kelvin to Celsius
      temp = getTemp.toStringAsFixed(1);
      humidity = getHumidity;
      description = getDesc;
      airSpeed = getAirSpeed.toString();
      main = getMainDes;
      icon = getIcon;
    } catch (e) {
      // Assigning default values in case of error
      temp = "NA";
      humidity = "NA";
      description = "Can't find data";
      airSpeed = "NA";
      main = "NA";
      icon = "NA";
    }
  }
}
