import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prodep_client/widgets/prodepfb/prodepfb-card.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-normal.dart';
import 'package:prodep_client/widgets/userinfo-widget.dart';

class ProdepfbMain extends StatefulWidget {
  static const routeName = "/prodepfb-main";

  const ProdepfbMain({Key? key}) : super(key: key);

  @override
  State<ProdepfbMain> createState() => _ProdepfbMainState();
}

class _ProdepfbMainState extends State<ProdepfbMain> {
  late List<dynamic> _userData;
  bool _isLoading = false;
  bool _unloadNormalScreen = false;
  List<dynamic> _imageUrls = [];

  String url =
      "https://graph.facebook.com/me?fields=id,name,posts{attachments}&access_token=";

  Future<void> getPosts() async {
    setState(() {
      _imageUrls = [];
      _userData = [];
      _isLoading = true;
      _unloadNormalScreen = true;
    });

    final result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email', 'user_posts']);
    final token = result.accessToken!.token;

    if (result.status == LoginStatus.success) {
      http.Response res = await http.get(Uri.parse("$url$token"));

      setState(() {
        _userData = jsonDecode(res.body)['posts']['data'];
      });

      getImageUrls();
    }
  }

  void getImageUrls() {
    _userData.forEach((element) {
      if (element['attachments']['data'][0]['media'] != null) {
        setState(() {
          _imageUrls
              .add(element['attachments']['data'][0]['media']['image']['src']);
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
                            width: 250,
                            child: ElevatedButton.icon(
                              icon: const Icon(FontAwesomeIcons.facebook),
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
                                getPosts();
                                // Navigator.of(context)
                                //     .pushNamed(LoginSelectionScreen.routeName);
                              },
                              label: const Text(
                                'RETRIEVE POSTS',
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
                ? Expanded(child: ProdepFbNormal())
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
                                itemCount: _imageUrls.length,
                                itemBuilder: ((context, index) {
                                  return ProdepfbCard(
                                    imageUrl: _imageUrls[index],
                                    username: usernameArg,
                                  );
                                }))),
                      ),
          ],
        ),
      ),
    );
  }
}
