import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider.dart';
import 'Screen/Home.dart';
import 'Screen/loading.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const Mausam(),
    ),
  );
}

class Mausam extends StatelessWidget {
  const Mausam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const Loading(),
        "/home": (context) => const Home(),
        "/loading": (context) => const Loading(),
      },
    );
  }
}
