import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveUserToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.userToken.name, token);
    return true;
  }

  String? getUserToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.userToken.name.toString());
  }

  Future<void> removeUserToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.userToken.name.toString());
  }

  Future<bool> saveFirebaseToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.firebaseToken.name, token);
    return true;
  }

  String? getFirebaseToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.firebaseToken.name.toString());
  }

  Future<void> removeFirebaseToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.firebaseToken.name.toString());
  }
}

enum CacheManagerKey { userToken, firebaseToken }
