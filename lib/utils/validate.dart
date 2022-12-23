import 'package:get/get.dart';

class Validator {
  Validator();

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return "Không đúng định dạng example@gmail.com";
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Minimum eight characters; at least one letter, one number and no special characters';
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.name'.tr;
    else
      return null;
  }

  String? number(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Không đúng định dạng';
    else
      return null;
  }

  String? amount(String? value) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.amount'.tr;
    else
      return null;
  }

  String? notEmpty(String? value, String title) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty)
      return 'Enter your $title';
    else
      return null;
  }

  String? nameFile(String value) {
    String pattern = r".";
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) return "Not empty";
    if (value.contains("."))
      return "Tên file không được chứa '.'";
    else
      return null;
  }
}
