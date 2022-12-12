import 'package:ielts/index.dart';

import '../models/item_menu.dart';

class ClientData {
  static var deviceInfo;
  static User? user;
  static final String defaultLanguage = 'vi';
  static final List<ItemMenu> languageOptions = [
    ItemMenu(key: "vi", value: "Tiếng Việt"),
    ItemMenu(key: "en", value: "English"),
  ];
}
