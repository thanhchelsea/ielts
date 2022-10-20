import 'package:get_storage/get_storage.dart';
import 'package:ielts/utils/preference/preference_manager.dart';

class PreferenceImpl implements PreferenceManager {
  final _storage = GetStorage();

  @override
  Future<dynamic> readStore({required String key}) async {
    return await _storage.read(key);
  }

  @override
  Future<void> writeStore({required String key, required value}) async {
    await _storage.write(key, value);
  }

  @override
  Future<bool> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String key) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}
