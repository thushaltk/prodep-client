import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProDepBotWidget extends StatefulWidget {
  const ProDepBotWidget({Key? key}) : super(key: key);

  @override
  State<ProDepBotWidget> createState() => _ProDepBotWidgetState();
}

class _ProDepBotWidgetState extends State<ProDepBotWidget> {
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
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
                        child: Text(
                          "Chatbot Summary",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFF393737),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Last conversation duration:",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF393737),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "30",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color(0xFF2B87CB),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "mins",
                            style: TextStyle(
                                fontSize: 35,
                                color: Color(0xFF2B87CB),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "status: ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF393737),),
                          ),
                          Text(
                            "GOOD",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        width: 120,
                        'assets/images/bot.png',
                        fit: BoxFit.contain,
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
