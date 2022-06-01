import 'package:act_steel_frontend/models/memo.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MemosController extends GetxController {
  List<Memo> _memos = [];
  List<Memo> get memos => _memos;

  addMemo(Memo memo) {
    _memos.add(memo);
    update();
  }
}
