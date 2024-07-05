import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Default to Mumbai if no city is provided
      startApp('Mumbai');
    });
  }

  startApp(String city) async {
    try {
      await Provider.of<WeatherProvider>(context, listen: false).fetchData(city);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
    if (search != null && search['searchText'] != null) {
      startApp(search['searchText']);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/img_1.png'), // Path to the new background image
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100), // Adjust as needed for spacing
              Image(
                image: AssetImage("Images/wbglogo.png"),
                height: 240,
                width: 240,
              ),
              Text(
                'Weather App',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,color: Colors.white),
              ),
              SizedBox(height: 10),
              Text('Made by Yash',style: TextStyle(color: Colors.white),),
              SizedBox(height: 20),
              SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
