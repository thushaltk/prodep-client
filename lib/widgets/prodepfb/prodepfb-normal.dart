import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProdepFbNormal extends StatelessWidget {
  const ProdepFbNormal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.facebook, color: Colors.blue[300], size: 80,),
            SizedBox(height: 45,),
            Text(
              "Facebook images goes here...",
              style: TextStyle(fontSize: 25, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
