import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
                "User 01",
                style: TextStyle(fontSize: 25),
              ),
              Text("COLOMBO"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
                fit: BoxFit.cover,
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
