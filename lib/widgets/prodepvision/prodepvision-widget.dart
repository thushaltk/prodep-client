import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProdepVisionWidget extends StatefulWidget {
  const ProdepVisionWidget({Key? key}) : super(key: key);

  @override
  State<ProdepVisionWidget> createState() => _ProdepVisionWidgetState();
}

class _ProdepVisionWidgetState extends State<ProdepVisionWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
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
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Today's Social Media Usage",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFF393737),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "09",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                          Text(
                            "Hrs",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                          Text(
                            "30",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                          Text(
                            "mins",
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF393737),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Too Much",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF393737),
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
                      Text("Prominent Emotion"),
                      Image.asset(
                        width: 70,
                        'assets/images/happyface.png',
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "POSITIVE",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 23,
                          fontWeight: FontWeight.bold
                        ),
                      ),
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
