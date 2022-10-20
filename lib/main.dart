import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ielts/screens/main/main_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) async {
    runApp(MainView());
  });
}
