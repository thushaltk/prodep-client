import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:prodep_client/screens/backgroundrun-warning-screen.dart';
import 'package:prodep_client/screens/enable-notifications-screen.dart';
import 'package:prodep_client/screens/enter-district-screen.dart';
import 'package:prodep_client/screens/linkfb-screen.dart';
import 'package:prodep_client/screens/linktwitter-screen.dart';
import 'package:prodep_client/screens/login-screen.dart';
import 'package:prodep_client/screens/main-screen.dart';
import 'package:prodep_client/screens/splash-screen.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({Key? key, required this.camera}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRODEP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tenorite',
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        EnableNotificationsScreen.routeName: (ctx) =>
            const EnableNotificationsScreen(),
        EnterDistrictScreen.routeName: (ctx) => EnterDistrictScreen(),
        BackgroundRunWarningScreen.routeName: (ctx) =>
            const BackgroundRunWarningScreen(),
        MainScreen.routeName: (ctx) => const MainScreen(),
        ProdepVisionMain.routeName: (ctx) => ProdepVisionMain(
              camera: camera,
            )
      },
    );
  }
}
