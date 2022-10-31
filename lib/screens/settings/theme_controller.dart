import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/base/index.dart';

import '../../utils/index.dart';

class ThemeController extends BaseController {
  static ThemeController get to => Get.find();
  final theme = "light".obs;
  final store = PreferenceImpl();
  ThemeMode? _themeMode;

  ThemeMode? get themeMode => _themeMode;
  String get currentTheme => theme.value;

  Future<void> setThemeMode(String value) async {
    theme.value = value;
    _themeMode = getThemeModeFromString(value);
    Get.changeThemeMode(_themeMode!);
    callDataService(
      store.writeStore(key: PreferenceManager.keyTheme, value: value),
      onSuccess: (response) {
        update();
      },
    );
  }

  ThemeMode getThemeModeFromString(String themeString) {
    ThemeMode _setThemeMode = ThemeMode.light;
    if (themeString == 'light') {
      _setThemeMode = ThemeMode.light;
    }
    if (themeString == 'dark') {
      _setThemeMode = ThemeMode.dark;
    }
    update();
    return _setThemeMode;
  }

  getThemeModeFromStore() async {
    callDataService(
      store.readStore(key: PreferenceManager.keyTheme),
      onSuccess: (response) {
        String _themeString = "";
        if (response == null) {
          _themeString = 'light';
        } else if (response == "system") _themeString = 'light';
        setThemeMode(_themeString);
        update();
      },
    );
  }

  bool get isDarkModeOn {
    if (currentTheme == 'dark') {
      return true;
    }
    return false;
  }

  @override
  void onReady() async {
    await getThemeModeFromStore();
    super.onReady();
  }
}
