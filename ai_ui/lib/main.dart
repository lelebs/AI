import 'package:ai_ui/Routes/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constants.dart' as Constants;
import 'Routes/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: futureMainPage());
  }

  futureMainPage() {
    return FutureBuilder(
        future: _decideMainPage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<dynamic> _decideMainPage() async {
    var prefs = FlutterSecureStorage();
    if (await prefs.containsKey(key: Constants.AuthKey))
      return HomePage();
    else
      return Login();
  }
}
