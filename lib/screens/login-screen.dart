import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:prodep_client/screens/main-screen.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map? _userData;

  Future<void> login() async {
    final result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email', 'user_posts']);
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email,name,posts{attachments}",
      );
      setState(() {
        _userData = requestData;
      });
      Navigator.of(context).pushNamed(MainScreen.routeName);
    }
  }

  Future<void> twitterLogin() async {
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: "NoIAujmA3P1vkJeb8IsjaWJi1",

      /// Consumer API Secret keys
      apiSecretKey: "N8V93zlKkA6QEZWClTiiscvof6fkMCzmtanjAIPJfDPM5d2hZM",

      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: 'twittersdk://',
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        print(authResult.authToken);
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        // error
        print('====== Login error ======');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Image.asset(
                            width: 280,
                            'assets/images/logo.png',
                            fit: BoxFit.contain),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 280,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.facebook),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF393737)),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(18.0),
                                  ),
                                ),
                                onPressed: () {
                                  login();
                                  // Navigator.of(context)
                                  //     .pushNamed(LoginSelectionScreen.routeName);
                                },
                                label: const Text(
                                  'LINK FACEBOOK ACCOUNT',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ColoredBox(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Flexible(
                                    child: Divider(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'or',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Divider(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
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
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(18.0),
                                  ),
                                ),
                                onPressed: () {
                                  twitterLogin();
                                  // Navigator.of(context)
                                  //     .pushNamed(LoginSelectionScreen.routeName);
                                },
                                label: const Text(
                                  'LINK TWITTER ACCOUNT',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      width: double.infinity,
                      child: Image.asset(
                          width: 330,
                          'assets/images/pattern2.png',
                          fit: BoxFit.contain),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 280,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Color(0xFF393737),
                                ),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(18.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(MainScreen.routeName);
                          },
                          child: const Text(
                            'Continue without login',
                            style: TextStyle(
                              color: Color(0xFF393737),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            'Who we are?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          height: 150,
                          alignment: Alignment.bottomCenter,
                          child: const Text(
                            'What we do?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ));
  }
}
