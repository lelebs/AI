import 'package:ai_ui/Routes/login.dart';
import 'package:ai_ui/routes/textRecognizerPage.dart';
import 'package:ai_ui/services/router.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'constants.dart' as Constants;
import 'Routes/homePage.dart';

GetIt locator = GetIt();

void main() {
  setupLocator();
  runApp(MyApp());
}


void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
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
        navigatorKey: locator<NavigationService>().navigatorKey,
        home: futureMainPage(),
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case Constants.TextRecognizerPage:
              return MaterialPageRoute(builder: (context) =>
                TextRecognizerPage()
              );
              break;
            //case Constants.TextConfirmationPage:
            //  return MaterialPageRoute(builder: (context) => 
            //    )
            default:
              return MaterialPageRoute(builder: (context) => HomePage());
          }
        },);
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
