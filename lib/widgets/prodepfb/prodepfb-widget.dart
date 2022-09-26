import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProdepFbWidget extends StatefulWidget {
  const ProdepFbWidget({Key? key}) : super(key: key);

  @override
  State<ProdepFbWidget> createState() => _ProdepFbWidgetState();
}

class _ProdepFbWidgetState extends State<ProdepFbWidget> {
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  int hours = 0;
  int minutes = 0;
  String text = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initUsage();
    });
  }

  Future<void> initUsage() async {
    int totalHours = 0;
    int totalMinutes = 0;
    List<AppUsageInfo> infoList =
        await AppUsage.getAppUsage(startDate, endDate);

    infoList.reversed.toList().forEach((element) {
      if (element.packageName == "com.facebook.katana") {
        totalHours = totalHours + element.usage.inHours;
        totalMinutes = totalMinutes + element.usage.inMinutes;
      }
    });

    this.setState(() {
      if (totalHours <= 3) {
        text = "Good usage";
      } else if (totalHours > 3 && totalHours <= 5) {
        text = "Try to reduce";
      } else {
        text = "Too much";
      }

      hours = totalHours;
      minutes = totalMinutes;
    });
  }

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
            // Navigator.of(context).pushNamed(ProdepVisionMain.routeName);
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
                          "Today's Social Media Usage",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFF393737),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      hours <= 3
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  hours.toString(),
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
                                  minutes.toString(),
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
                          : hours > 3 && hours <= 5
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      hours.toString(),
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
                                      minutes.toString(),
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
                                      hours.toString(),
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
                                      minutes.toString(),
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
                      hours <= 3
                          ? Text(
                              text,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            )
                          : hours > 3 && hours <= 5
                              ? Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 235, 82, 12),
                                  ),
                                )
                              : Text(
                                  text,
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
