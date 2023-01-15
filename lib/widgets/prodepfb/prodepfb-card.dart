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
import 'package:prodep_client/services/prodepfb-service.dart';

class ProdepfbCard extends StatefulWidget {
  final String imageUrl;
  final String username;

  const ProdepfbCard({Key? key, required this.imageUrl, required this.username}) : super(key: key);

  @override
  State<ProdepfbCard> createState() => _ProdepfbCardState();
}

class _ProdepfbCardState extends State<ProdepfbCard> {
  late ProdepFBService prodepFBService;
  late Future<void> _initializeControllerFuture;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String result = "";
  bool isLoading = false;
  File? _photo;
  var url = "http://192.168.8.161:8000/api/prodepfb";
  //var url = "http://192.168.1.4:8000/api/prodepfb";
  //var url = "http://192.168.28.170:8000/api/prodepfb";
  //var url = "http://172.28.25.12:8000/api/prodepfb";

  @override
  void initState() {
    super.initState();
    prodepFBService = new ProdepFBService();
  }

  Future convertImageToFile() async {
    if (widget.imageUrl == null) return;

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File("$tempPath sample.jpg");

    http.Response response = await http.get(Uri.parse(widget.imageUrl));
    File tempPhoto = await tempFile.writeAsBytes(response.bodyBytes);

    setState(() {
      _photo = File(tempPhoto.path);
    });
  }

  //Upload image to the firebase storage
  Future uploadFile() async {
    setState(
      () {
        isLoading = true;
      },
    );
    await convertImageToFile();

    const fileName = "sample";
    const destination = '/prodepfb/$fileName.jpg';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(_photo!);

      Timer(
        const Duration(seconds: 10),
        () async {
          await analyzeSentimentProcess();
        },
      );
    } catch (e) {
      print('error occured');
    }
  }

  Future<void> analyzeSentimentProcess() async {
    String date = DateFormat("yyyy/MM/dd").format(DateTime.now());
    try {
      http.Response res = await http.post(Uri.parse(url));
      setState(() {
        result = jsonDecode(res.body)['result'];
        isLoading = false;
      });

      await prodepFBService.saveFBData(widget.username, date, result);
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
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(widget.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 130,
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            FontAwesomeIcons.satellite,
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
                            uploadFile();
                            // Navigator.of(context)
                            //     .pushNamed(LoginSelectionScreen.routeName);
                          },
                          label: const Text(
                            'Analyze',
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
