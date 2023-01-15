import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/widgets/maindate-widget.dart';
import 'package:prodep_client/widgets/prodepbot/prodepbot-widget.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-widget.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptwitter-widget.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-widget.dart';
import 'package:prodep_client/widgets/userinfo-widget.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main";

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  int hours = 0;
  int minutes = 0;
  int fbHours = 0;
  int fbMinutes = 0;
  int twitterHours = 0;
  int twitterMinutes = 0;
  String text = "";
  String fbText = "";
  String twitterText = "";

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
    int totalFbHours = 0;
    int totalFbMinutes = 0;
    int totalTwitterHours = 0;
    int totalTwitterMinutes = 0;

    List<AppUsageInfo> infoList =
        await AppUsage.getAppUsage(startDate, endDate);

    infoList.reversed.toList().forEach((element) {
      if (element.packageName == "com.facebook.katana") {
        //calculate total hours - facebook usage
        totalHours =
            totalHours + int.parse((element.usage.toString().split(":"))[0]);
        //calculate total minutes - facebook usage
        totalMinutes =
            totalMinutes + int.parse((element.usage.toString().split(":"))[1]);

        totalFbHours = int.parse((element.usage.toString().split(":"))[0]);
        totalFbMinutes = int.parse((element.usage.toString().split(":"))[1]);

        if (totalMinutes >= 59) {
          totalHours = totalHours + 1;
          totalMinutes = totalMinutes - 60;
        }
      }

      if (element.packageName == "com.twitter.android") {
        totalHours =
            totalHours + int.parse((element.usage.toString().split(":"))[0]);
        totalMinutes =
            totalMinutes + int.parse((element.usage.toString().split(":"))[1]);

        totalTwitterHours = int.parse((element.usage.toString().split(":"))[0]);
        totalTwitterMinutes =
            int.parse((element.usage.toString().split(":"))[1]);

        if (totalMinutes >= 59) {
          totalHours = totalHours + 1;
          totalMinutes = totalMinutes - 60;
        }
      }

      if (element.packageName == "com.google.android.youtube" ||
          element.packageName == "com.instagram.android" ||
          element.packageName == "com.whatsapp") {
        totalHours =
            totalHours + int.parse((element.usage.toString().split(":"))[0]);
        totalMinutes =
            totalMinutes + int.parse((element.usage.toString().split(":"))[1]);

        if (totalMinutes >= 59) {
          totalHours = totalHours + 1;
          totalMinutes = totalMinutes - 60;
        }
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

      if (totalFbHours <= 3) {
        fbText = "Good usage";
      } else if (totalFbHours > 3 && totalFbHours <= 5) {
        fbText = "Try to reduce";
      } else {
        fbText = "Too much";
      }

      if (totalTwitterHours <= 3) {
        twitterText = "Good usage";
      } else if (totalTwitterHours > 3 && totalTwitterHours <= 5) {
        twitterText = "Try to reduce";
      } else {
        twitterText = "Too much";
      }

      hours = totalHours;
      minutes = totalMinutes;
      fbHours = totalFbHours;
      fbMinutes = totalFbMinutes;
      twitterHours = totalTwitterHours;
      twitterMinutes = totalTwitterMinutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    var usernameArg = args['username'];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: initUsage,
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
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
                    padding: const EdgeInsets.only(top: 38.0),
                    child: MainDateWidget(),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ProdepVisionWidget(
                          username: usernameArg,
                          hours: hours,
                          minutes: minutes,
                          text: text,
                        ),
                        ProdepFbWidget(
                          username: usernameArg,
                          hours: fbHours,
                          minutes: fbMinutes,
                          text: fbText,
                        ),
                        ProdepTwitterWidget(
                          username: usernameArg,
                          hours: twitterHours,
                          minutes: twitterMinutes,
                          text: twitterText,
                        ),
                        ProDepBotWidget()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
