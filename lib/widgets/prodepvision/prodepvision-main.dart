import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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

  @override
  void initState(){
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


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}