import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EnableNotificationsScreen extends StatelessWidget {
  const EnableNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Image.asset(
                width: 200,
                'assets/images/notify-bell.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Enable Notifications',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  width: double.infinity,
                  child: Image.asset(
                      width: 330,
                      'assets/images/pattern2.png',
                      fit: BoxFit.contain),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        'What we do?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
