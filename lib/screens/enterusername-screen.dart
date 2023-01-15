import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prodep_client/screens/backgroundrun-warning-screen.dart';
import 'package:prodep_client/screens/main-screen.dart';

class EnterUsernameScreen extends StatefulWidget {
  static const routeName = "/enterUsername";
  EnterUsernameScreen({Key? key}) : super(key: key);

  @override
  State<EnterUsernameScreen> createState() => _EnterUsernameScreenState();
}

class _EnterUsernameScreenState extends State<EnterUsernameScreen> {
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Image.asset(
                      width: 150,
                      'assets/images/user.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Enter any username',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Enter any username that you prefer using in this app',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 330,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter username',
                        labelText: 'Username',
                      ),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  )
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
                Container(
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF393737)),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(18.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(MainScreen.routeName, arguments: {
                          'username': _usernameController.text
                        });
                      },
                      child: const Text(
                        'PROCEED',
                        style: TextStyle(
                          fontSize: 13,
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
    );
  }
}
