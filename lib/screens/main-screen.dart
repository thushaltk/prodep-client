import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/maindate-widget.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-widget.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptwitter-widget.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-widget.dart';
import 'package:prodep_client/widgets/userinfo-widget.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main";

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: 350,
                  child: Image.asset(
                      width: 330,
                      'assets/images/pattern.png',
                      fit: BoxFit.contain),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(Icons.arrow_back, size: 35),
                      ),
                      Container(
                        width: 250,
                        height: 100,
                        child: const UserInfoWidget(
                          username: '',
                          userdistrict: '',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: MainDateWidget(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ProdepVisionWidget(),
                      ProdepFbWidget(),
                      ProdepTwitterWidget()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
