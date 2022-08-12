import 'package:flutter/material.dart';
import 'package:prodep_client/screens/enable-notifications-screen.dart';
import 'package:prodep_client/screens/enter-district-screen.dart';
import 'package:prodep_client/screens/splash-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRODEP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: EnterDistrictScreen(),
    );
  }
}
