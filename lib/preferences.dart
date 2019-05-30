import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class Preferences {
  static Future<String> getCity() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString("city") ?? "Montpellier";
  }
}
