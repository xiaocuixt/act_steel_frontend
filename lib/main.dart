import 'package:act_steel_frontend/routes/route_helper.dart';
import 'package:act_steel_frontend/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:act_steel_frontend/config/dependencies.dart' as dep;

void main() async {
  dep.init();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setPathUrlStrategy();

  runApp(GetMaterialApp(
    home: MainPage(),
    getPages: RouteHelper.routes,
  ));
}
