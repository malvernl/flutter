import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => Loading(), //Context Object are taken in the function as argument
        '/home' : (context) => Home(),
        '/location' : (context) => ChooseLocation(),
      },
    );
  }
}