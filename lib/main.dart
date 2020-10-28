import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:FoodFacts/models/constants.dart';
import 'package:FoodFacts/models/router.dart' as router;

void main() {
  analytics = FirebaseAnalytics();
  runApp(MyApp());
}

FirebaseAnalytics analytics;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.blue[300],
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.blue[900],
        systemNavigationBarIconBrightness: Brightness.light));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodFacts',
      onGenerateRoute: router.generateRoute,
      initialRoute: HomePageRoute,
    );
  }
}
