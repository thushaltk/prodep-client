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
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [DateDaysWidget()],
        ),
      ),
    );
  }
}
