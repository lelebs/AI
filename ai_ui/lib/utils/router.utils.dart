import 'package:ai_ui/Routes/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants.dart' as Constants;

class RouterService {
  static Future<MaterialPageRoute> buildRoute(Widget route) async {
    final prefs = FlutterSecureStorage();

    if (await prefs.containsKey(key: Constants.AuthKey))
      return new MaterialPageRoute(
        builder: (ctx) => route,
      );
    else
      return new MaterialPageRoute(
        builder: (ctx) => Login(),
      );
  }
}
