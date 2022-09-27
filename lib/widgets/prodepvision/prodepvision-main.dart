import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProdepVisionMain extends StatefulWidget {
  static const routeName = "/prodepvision-main";
  final CameraDescription camera;

  const ProdepVisionMain({Key? key, required this.camera}) : super(key: key);

  @override
  State<ProdepVisionMain> createState() => _ProdepVisionMainState();
}

class _ProdepVisionMainState extends State<ProdepVisionMain> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  String emotionLabel = "---";
  String earValue = "0.00";
  bool isLoading = false;
  var url = "http://192.168.1.2:8000/api/prodepvision";

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = "sample";
    final destination = '/$fileName.jpg';

    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }

    Future<void> getData() async {
      try {
        Response res = await http.post(Uri.parse(url));
        setState(() {
          emotionLabel = jsonDecode(res.body)['emotion'];
          earValue = jsonDecode(res.body)['ear'].toString();
        });
      } catch (e) {
        print(e);
      }
    }

    //TODO: add timer and POST request here
    Timer(const Duration(seconds: 10), () async {
      getData();
      setState(() {
        isLoading = false;
      });
    });
  }

  Future imgFromCamera() async {
    setState(() {
      isLoading = true;
      emotionLabel = "Analyzing...";
      earValue = "Analyzing...";
    });
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await _controller.takePicture();
      setState(() {
        if (image != null) {
          _photo = File(image.path);
          uploadFile();
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 38.0, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 500,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return CameraPreview(_controller);
                  } else {
                    // Otherwise, display a loading indicator.
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          isLoading
              ? CircularProgressIndicator()
              : Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton.icon(
                      icon: const Icon(FontAwesomeIcons.camera),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF393737)),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(18.0),
                        ),
                      ),
                      onPressed: () {
                        imgFromCamera();
                        // Navigator.of(context)
                        //     .pushNamed(LoginSelectionScreen.routeName);
                      },
                      label: const Text(
                        'Capture and Analyze',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 38.0, left: 38.0, right: 38.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Detected Emotion :  ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  emotionLabel,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0, right: 38.0, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "EAR value :  ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  earValue,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
