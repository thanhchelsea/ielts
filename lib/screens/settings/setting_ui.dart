import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/item_menu.dart';
import 'index.dart';

class SettingsUI extends StatelessWidget {
  //final LanguageController languageController = LanguageController.to;
  //final ThemeController themeController = ThemeController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        themeListTile(context),
      ],
    );
  }

  themeListTile(BuildContext context) {
    final List<ItemMenu> themeOptions = [
      ItemMenu(key: "light", value: 'settings.light'.tr),
      ItemMenu(key: "dark", value: 'settings.dark'.tr)
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => Column(
        children: [
          ListTile(
            title: Text('settings.theme'.tr),
          ),
          Container(),
        ],
      ),
    );
  }
}
