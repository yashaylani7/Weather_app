import 'package:flutter/material.dart';

class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}
class _locationState extends State<location> {

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Location'),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
