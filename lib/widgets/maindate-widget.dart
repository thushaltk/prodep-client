import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/datedays-widget.dart';

class MainDateWidget extends StatefulWidget {
  const MainDateWidget({Key? key}) : super(key: key);

  @override
  State<MainDateWidget> createState() => _MainDateWidgetState();
}

class _MainDateWidgetState extends State<MainDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Container(
        width: double.infinity,
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Good Morning!..",
                    style: TextStyle(fontSize: 35),
                  ),
                ),

              ],
            ),
            DateDaysWidget()
          ],
        ),
      ),
    );
  }
}
