import 'package:get/get_state_manager/get_state_manager.dart';

class AvatarController extends GetxController {
  String _avatar = '';
  String get avatar => _avatar;

  setAvatar(avatar) {
    _avatar = avatar;
    update();
  }
}
