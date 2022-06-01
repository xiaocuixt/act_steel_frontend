import 'package:act_steel_frontend/services/login_info.dart';
import 'package:act_steel_frontend/views/main_page.dart';
import 'package:act_steel_frontend/views/profile_page.dart';
import 'package:act_steel_frontend/views/users/login_user.dart';
import 'package:act_steel_frontend/views/users/register_user.dart';
import 'package:act_steel_frontend/views/users/user_profile.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RouteHelper {
  static const String initial = "/";
  static const String loginUser = "/login";
  static const String userProfile = "/profile";
  static const String profilePage = "/dashboard";
  static const String registerUser = "/signup";
  static final loginInfo = LoginInfo();

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          print('main page.');
          GetStorage box = GetStorage();
          return box.hasData('token') ? MainPage() : LoginUser();
        }),
    GetPage(
      name: loginUser,
      page: () => LoginUser(),
    ),
    GetPage(
      name: registerUser,
      page: () => RegisterUser(),
    ),
    GetPage(
        name: userProfile,
        page: () {
          return loginInfo.loggedIn ? UserProfile() : LoginUser();
        }),
    GetPage(
        name: profilePage,
        page: () {
          GetStorage box = GetStorage();
          print('profile page.');
          return box.hasData('token') ? ProfilePage() : LoginUser();
        }),
  ];
}
