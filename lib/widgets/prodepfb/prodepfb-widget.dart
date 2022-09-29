import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-main.dart';

class ProdepFbWidget extends StatefulWidget {
  final int hours;
  final int minutes;
  final String text;

  const ProdepFbWidget({Key? key, required this.hours, required this.minutes, required this.text}) : super(key: key);

  @override
  State<ProdepFbWidget> createState() => _ProdepFbWidgetState();
}

class _ProdepFbWidgetState extends State<ProdepFbWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            //getCameras();
            Navigator.of(context).pushNamed(ProdepfbMain.routeName);
            // debugPrint('Card tapped.');
          },
          child: Container(
            width: double.infinity,
            height: 200,
            child: Row(
              children: [
                SizedBox(
                  width: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Today's Facebook Usage",
                          style: TextStyle(
                              fontSize: 23,
                              color: Color(0xFF393737),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      widget.hours <= 3
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.hours.toString(),
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  "Hrs",
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  widget.minutes.toString(),
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  "mins",
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          : widget.hours > 3 && widget.hours <= 5
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.hours.toString(),
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Color.fromARGB(255, 235, 82, 12),
                                      ),
                                    ),
                                    Text(
                                      "Hrs",
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Color.fromARGB(255, 235, 82, 12),
                                      ),
                                    ),
                                    Text(
                                      widget.minutes.toString(),
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Color.fromARGB(255, 235, 82, 12),
                                      ),
                                    ),
                                    Text(
                                      "mins",
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Color.fromARGB(255, 235, 82, 12),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.hours.toString(),
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "Hrs",
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      widget.minutes.toString(),
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "mins",
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                      widget.hours <= 3
                          ? Text(
                              widget.text,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            )
                          : widget.hours > 3 && widget.hours <= 5
                              ? Text(
                                  widget.text,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 235, 82, 12),
                                  ),
                                )
                              : Text(
                                  widget.text,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 20,
                  thickness: 1,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Prominent Emotion"),
                      Image.asset(
                        width: 70,
                        'assets/images/happyface.png',
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        "POSITIVE",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("See more >>")
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
