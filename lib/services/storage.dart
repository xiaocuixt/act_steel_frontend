import 'package:get_storage/get_storage.dart';

class Storage {
  final _box = GetStorage();

  // 读取
  String _getToken() => _box.read('token') ?? "";
  String get token => _getToken();

  // 添加
  void setToken(String token) => _box.write('token', token);
  // 清除
  void clearToken() => _box.remove('token');
}
