import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/userinfo-widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(Icons.arrow_back, size: 35),
          ),
          Container(
            width: 200,
            height: 100,
            child: const UserInfoWidget(
              username: '',
              userdistrict: '',
            ),
          ),
        ],
      ),
    );
  }
}
