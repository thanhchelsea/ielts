abstract class PreferenceManager {
  static const keyToken = "token";
  static const keyTheme = "theme";

  Future<dynamic> readStore({required String key});
  Future<void> writeStore({required String key, required dynamic value});

  Future<bool> remove(String key);
  Future<bool> clear();
}
