import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProdepVisionNormal extends StatelessWidget {
  const ProdepVisionNormal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Let us analyze your ",
              style: TextStyle(fontSize: 35, color: Colors.black54),
            ),
          Image.asset("assets/images/vision.png"),
          
        ],
      ),
    );
  }
}