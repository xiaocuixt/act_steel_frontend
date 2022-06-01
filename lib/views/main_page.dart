import 'package:act_steel_frontend/controllers/bottom_bar_controller.dart';
import 'package:act_steel_frontend/services/login_info.dart';
import 'package:act_steel_frontend/views/profile_page.dart';
import 'package:act_steel_frontend/views/home_page.dart';
import 'package:act_steel_frontend/views/users/login_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LoginInfo loginInfo = LoginInfo();
  List pages = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      init: BottomBarController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: loginInfo.loggedIn ? pages[controller.tabIndex] : LoginUser(),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              selectedItemColor: Colors.amber[800],
              unselectedItemColor: Colors.grey.withOpacity(0.5),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              items: [
                BottomNavigationBarItem(label: 'home', icon: Icon(Icons.apps)),
                BottomNavigationBarItem(label: 'My', icon: Icon(Icons.person)),
              ]),
        );
      },
    );
  }
}
