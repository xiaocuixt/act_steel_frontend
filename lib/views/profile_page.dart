import 'package:act_steel_frontend/helpers/app_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:act_steel_frontend/views/users/user_profile.dart';
import 'package:get/get.dart';
import 'package:act_steel_frontend/services/storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: AppBarHelper(title: "User Profile")),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 200,
            child: UserProfile(),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Storage().clearToken();
              Get.toNamed('/profile');
            },
            child: const Text(
              'logout',
            ),
          ),
        ],
      ),
    );
  }
}
