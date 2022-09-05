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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        width: 50,
        height: 70,
        child: Text(widget.day),
      ),
    );
  }
}
