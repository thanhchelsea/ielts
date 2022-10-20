import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ielts/screens/main/index.dart';
import '../../index.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return GetBuilder<LanguageController>(
          builder: (languageController) {
            return GetMaterialApp(
              translations: Localization(),
              locale: languageController.getLocale,
              navigatorObservers: [],
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme(context), //AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme(context),
              themeMode: controller.themeMode,
              initialRoute: RouterNames.HOME,
              getPages: AppRoutes.routes,
            );
          },
        );
      },
    );
  }
}
