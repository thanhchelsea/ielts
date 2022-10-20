import '../models/item_menu.dart';

class ClientData {
  static final String defaultLanguage = 'vi';
  static final List<ItemMenu> languageOptions = [
    ItemMenu(key: "vi", value: "Tiếng Việt"),
    ItemMenu(key: "en", value: "English"),
  ];
}
