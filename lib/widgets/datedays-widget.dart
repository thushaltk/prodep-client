import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/singleday-widget.dart';

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
          width: double.infinity,
          color: Colors.red,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleDayWidget(day: "1"),
                SingleDayWidget(day: "2"),
                SingleDayWidget(day: "3"),
                SingleDayWidget(day: "4"),
                SingleDayWidget(day: "5"),
                SingleDayWidget(day: "6"),
                SingleDayWidget(day: "7"),
                SingleDayWidget(day: "8"),
                SingleDayWidget(day: "9"),
                SingleDayWidget(day: "10"),
                SingleDayWidget(day: "11"),
              ],
            ),
          )),
    );
  }
}
