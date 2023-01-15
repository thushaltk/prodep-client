import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:prodep_client/services/prodepfb-service.dart';
import 'package:prodep_client/services/prodeptweet-service.dart';
import 'package:prodep_client/services/prodepvision-service.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-chart.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfbcount-card.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptweet-chart.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptweetcount-card.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-chart.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-earchart.dart';
import 'package:prodep_client/widgets/userinfo-widget.dart';

class Prodeptweetreport extends StatefulWidget {
  static const routeName = "/prodeptweet-report";
  const Prodeptweetreport({Key? key}) : super(key: key);

  @override
  State<Prodeptweetreport> createState() => _ProdeptweetreportState();
}

class _ProdeptweetreportState extends State<Prodeptweetreport> {
  late ProdepTweetService prodepTweetService;
  late String username;
  int positiveCount = 0;
  int negativeCount = 0;
  DateTime todayDate = DateTime.now();
  String selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: todayDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != todayDate) {
      setState(() {
        positiveCount = 0;
        negativeCount = 0;
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
        initialise();
      });
    }
  }

  initialise() async {
    prodepTweetService = ProdepTweetService();
    prodepTweetService.initialise();

    await prodepTweetService.getAllTweetData().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (value[i]['username'] == username && value[i]['date'] == selectedDate) {
          if (value[i]['sentimentValue'] == "NEGATIVE") {
            setState(() => {negativeCount++});
          } else {
            setState(() => {positiveCount++});
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    var usernameArg = args['username'];
    setState(() {
      username = usernameArg;
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: 350,
                  child: Image.asset(
                      width: 330,
                      'assets/images/pattern.png',
                      fit: BoxFit.contain),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back, size: 35),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 100,
                        child: UserInfoWidget(
                          username: usernameArg,
                          userdistrict: '',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 160.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                            child: ElevatedButton.icon(
                              icon: const Icon(FontAwesomeIcons.calendar),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF393737)),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(18.0),
                                ),
                              ),
                              onPressed: () {
                                _selectDate(context);
                                // Navigator.of(context)
                                //     .pushNamed(LoginSelectionScreen.routeName);
                              },
                              label: const Text(
                                'SELECT DATE',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: Text(
                            "Daily Report : "+selectedDate.toString(),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text("Sentiment values as percentages"),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: Prodeptweetchart(
                        username: username,
                        date: selectedDate,
                        positiveCount: positiveCount,
                        negativeCount: negativeCount,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Prodeptweetcountcard(sentimentValue: positiveCount, sentimentType: "POSITIVE"),
                        Prodeptweetcountcard(sentimentValue: negativeCount, sentimentType: "NEGATIVE")
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
