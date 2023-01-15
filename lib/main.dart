import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prodep_client/screens/backgroundrun-warning-screen.dart';
import 'package:prodep_client/screens/enable-notifications-screen.dart';
import 'package:prodep_client/screens/enter-district-screen.dart';
import 'package:prodep_client/screens/enterusername-screen.dart';
import 'package:prodep_client/screens/linkfb-screen.dart';
import 'package:prodep_client/screens/linktwitter-screen.dart';
import 'package:prodep_client/screens/login-screen.dart';
import 'package:prodep_client/screens/main-screen.dart';
import 'package:prodep_client/screens/splash-screen.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-card.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-main.dart';
import 'package:prodep_client/widgets/prodepfb/prodepfb-report.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptweet-report.dart';
import 'package:prodep_client/widgets/prodeptwitter/prodeptwtter-main.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-main.dart';
import 'package:prodep_client/widgets/prodepvision/prodepvision-report.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyABJFu1mNu6I3YB3KDWRo8mNveq-Ue9Hzw", // Your apiKey
      appId: "1:860527556582:android:53bd4220833f48b95f0827", // Your appId
      messagingSenderId: "860527556582", // Your messagingSenderId
      projectId: "prodep-storage", // Your projectId
    ),
  );
  final cameras = await availableCameras();
  final firstCamera = cameras[1];
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
        EnterUsernameScreen.routeName: (ctx) => EnterUsernameScreen(),
        BackgroundRunWarningScreen.routeName: (ctx) =>
            const BackgroundRunWarningScreen(),
        MainScreen.routeName: (ctx) => const MainScreen(),
        ProdepVisionMain.routeName: (ctx) => ProdepVisionMain(
              camera: camera,
            ),
        Prodepvisionreport.routeName: (ctx) => Prodepvisionreport(),
        ProdepfbMain.routeName: (ctx) => ProdepfbMain(),
        Prodepfbreport.routeName: (ctx) => Prodepfbreport(),
        ProdepTwitterMain.routeName: (ctx) => ProdepTwitterMain(),
        Prodeptweetreport.routeName: (ctx) => Prodeptweetreport()
      },
    );
  }
}
