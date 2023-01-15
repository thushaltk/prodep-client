import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prodep_client/services/prodeptweet-service.dart';

class ProdepTwitterCard extends StatefulWidget {
  final String tweets;
  final String username;
  

  const ProdepTwitterCard({Key? key, required this.tweets, required this.username}) : super(key: key);

  @override
  State<ProdepTwitterCard> createState() => _ProdepTwitterCardState();
}

class _ProdepTwitterCardState extends State<ProdepTwitterCard> {
  late ProdepTweetService prodepTweetService;
  late Future<void> _initializeControllerFuture;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String result = "";
  bool isLoading = false;
  File? _photo;
  var url = "http://192.168.8.161:8000/api/prodeptweet";
  //var url = "http://192.168.1.4:8000/api/prodeptweet";
  //var url = "http://192.168.28.170:8000/api/prodeptweet";
  //var url = "http://172.28.25.12:8000/api/prodeptweet";

  @override
  void initState() {
    super.initState();
    prodepTweetService = new ProdepTweetService();
  }

  Future<void> analyzeSentimentProcess() async {
    String date = DateFormat("yyyy/MM/dd").format(DateTime.now());
    print(widget.tweets.toString());
    setState(() {
      isLoading = true;
    });
    try {
      http.Response res = await http
          .post(Uri.parse(url), body: {"data": widget.tweets.toString()});
      Timer(
        const Duration(seconds: 2),
        () async {
          setState(() {
            result = jsonDecode(res.body)['result'];
            isLoading = false;
          });
      await prodepTweetService.saveTweetData(widget.username, date, result);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                      child: Text(
                    widget.tweets,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            FontAwesomeIcons.cog,
                            color: Color(0xFF393737),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Color(0xFF393737)))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(18.0),
                            ),
                          ),
                          onPressed: () {
                            analyzeSentimentProcess();
                            //uploadFile();
                            // Navigator.of(context)
                            //     .pushNamed(LoginSelectionScreen.routeName);
                          },
                          label: const Text(
                            'Analyze Tweet',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF393737)),
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Result : ",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  result == "NEGATIVE"
                      ? Text(
                          result,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          result,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
