import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProdepTwitterNormal extends StatelessWidget {
  const ProdepTwitterNormal({Key? key}) : super(key: key);

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
            Icon(FontAwesomeIcons.twitter, color: Colors.blue[300], size: 100,),
            SizedBox(height: 25,),
            Text(
              "Your Tweets goes here...",
              style: TextStyle(fontSize: 25, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
