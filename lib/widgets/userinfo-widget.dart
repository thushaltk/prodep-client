import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoWidget extends StatefulWidget {
  final String username;
  final String userdistrict;

  const UserInfoWidget(
      {Key? key, required this.username, required this.userdistrict})
      : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Prodep Sliit",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "COLOMBO",
                style: TextStyle(fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.notifications,
                    size: 15,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "assets/images/dp.png",
                fit: BoxFit.fitWidth,
                width: 60,
                height: 60,
              ),
            ),
          )
        ],
      ),
    );
  }
}
