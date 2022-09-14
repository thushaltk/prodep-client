import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleDayWidget extends StatefulWidget {
  final String day;

  const SingleDayWidget({Key? key, required this.day}) : super(key: key);

  @override
  State<SingleDayWidget> createState() => _SingleDayWidgetState();
}

class _SingleDayWidgetState extends State<SingleDayWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        width: 60,
        height: 80,
        child: Text(
          widget.day,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
