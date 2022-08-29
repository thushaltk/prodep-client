import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DateDaysWidget extends StatefulWidget {
  const DateDaysWidget({Key? key}) : super(key: key);

  @override
  State<DateDaysWidget> createState() => _DateDaysWidgetState();
}

class _DateDaysWidgetState extends State<DateDaysWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 70,
        color: Colors.red,
      ),
    );
  }
}
