import 'package:act_steel_frontend/controllers/avatar_controller.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // repos
  Get.lazyPut(() => AvatarController());
}
