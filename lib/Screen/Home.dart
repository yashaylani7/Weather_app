import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import '../provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);
    String city = weatherProvider.city;
    String temp = weatherProvider.temp;
    String airSpeed = weatherProvider.airSpeed;
    String description = weatherProvider.description;
    String humidity = weatherProvider.humidity;
    String icon = weatherProvider.icon;

    var cityNames = ['Mumbai', 'Delhi', 'Nagpur', 'Wardha'];
    final _random = Random();
    var randomCity = cityNames[_random.nextInt(cityNames.length)];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/img.png'), // Add your background image to assets and update this path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchController.text).replaceAll(" ", "") == '') {
                          print('blank search');
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            '/loading',
                            arguments: {
                              "searchText": searchController.text,
                            },
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(3, 0, 10, 0),
                        child: const Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search for $randomCity",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () async {
                      await weatherProvider.fetchData(city);
                    },
                  ),
                  const Text("Refresh"),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      padding: const EdgeInsets.all(23),
                      decoration: BoxDecoration(
                        color: Color(0xFFD4F1F9).withOpacity(0.7), // Light blue background with teal text/icons
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: Image.network(
                              'https://openweathermap.org/img/wn/$icon@2x.png',
                              color: Color(0xFF008080),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF008080),
                                ),
                              ),
                              Text(
                                city,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF008080),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(height: 30,),
                  Expanded(
                    child: Container(
                      height: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      padding: const EdgeInsets.all(26),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E6FA).withOpacity(0.7), // Lavender background with navy blue text/icons
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            WeatherIcons.thermometer,
                            size: 30,
                            color: Color(0xFF000080),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                temp,
                                style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000080),
                                ),
                              ),
                              const Text(
                                'C',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000080),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF98FB98).withOpacity(0.7), // Light green background with white text/icons
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(WeatherIcons.day_windy, color: Colors.white),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Air Speed', style: TextStyle(color: Colors.white)),
                                  Text(
                                    airSpeed,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE5B4).withOpacity(0.8), // Peach background with dark gray text/icons
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(WeatherIcons.humidity, color: Colors.white),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Humidity', style: TextStyle(color: Colors.white)),
                                  Text(
                                    humidity,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      color:Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
