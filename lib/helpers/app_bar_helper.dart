import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarHelper extends StatelessWidget {
  const AppBarHelper({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.supervised_user_circle_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed('/profile');
          },
        )
      ],
    );
  }
}
