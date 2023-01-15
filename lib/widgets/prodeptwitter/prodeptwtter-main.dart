import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prodep_client/widgets/prodepfb/prodepfb-card.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptwitter-card.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptwitter-normal.dart';
import 'package:prodep_client/widgets/userinfo-widget.dart';
import 'package:twitter_login/twitter_login.dart';

class ProdepTwitterMain extends StatefulWidget {
  static const routeName = "/prodeptwitter-main";

  const ProdepTwitterMain({Key? key}) : super(key: key);

  @override
  State<ProdepTwitterMain> createState() => _ProdepTwitterMainState();
}

class _ProdepTwitterMainState extends State<ProdepTwitterMain> {
  List<dynamic> _userData = [];
  bool _isLoading = false;
  bool _unloadNormalScreen = false;
  String bearerToken =
      "AAAAAAAAAAAAAAAAAAAAAKmCcAEAAAAAenCkTBhu45orQN%2Buozk7IKZuREU%3DwOQdQFcwhvrYwCXfcUckq48g91iJksHl2M6xRGKjQqlt03JmKb";

  List<dynamic> _sinhalaTweets = [];

  String url = "https://api.twitter.com/2/users/";

  Future<void> getTweets() async {
    setState(() {
      _userData = [];
      _isLoading = true;
      _unloadNormalScreen = true;
    });

    final twitterLogin = TwitterLogin(
      apiKey: "NoIAujmA3P1vkJeb8IsjaWJi1",
      apiSecretKey: "N8V93zlKkA6QEZWClTiiscvof6fkMCzmtanjAIPJfDPM5d2hZM",
      redirectURI: 'twittersdk://',
    );

    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        http.Response res = await http.get(
            Uri.parse(
                "$url${authResult.user!.id}/tweets?max_results=100&tweet.fields=lang"),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $bearerToken',
            });
        //print(jsonDecode(res.body)["data"].length);
        setState(() {
          _userData = jsonDecode(res.body)["data"];
          _isLoading = false;
        });
        getSinhalaTweets();
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        print('====== Login error ======');
        break;
    }
  }

  void getSinhalaTweets() {
    _userData.forEach((element) {
      if (element['lang'] == "si") {
        print(element['text']);
        setState(() {
          _sinhalaTweets.add(element['text']);
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    var usernameArg = args['username'];
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
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 280,
                            child: ElevatedButton.icon(
                              icon: const Icon(FontAwesomeIcons.twitter),
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
                                getTweets();
                                // Navigator.of(context)
                                //     .pushNamed(LoginSelectionScreen.routeName);
                              },
                              label: const Text(
                                'RETRIEVE SINHALA TWEETS',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
            _unloadNormalScreen == false
                ? Expanded(child: ProdepTwitterNormal())
                : _isLoading
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(child: CircularProgressIndicator()),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: _sinhalaTweets.length,
                            itemBuilder: ((context, index) {
                              return ProdepTwitterCard(
                                  tweets: _sinhalaTweets[index],
                                  username: usernameArg,);
                            }),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
