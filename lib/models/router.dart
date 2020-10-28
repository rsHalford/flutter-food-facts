import 'package:flutter/material.dart';

import 'package:FoodFacts/models/constants.dart';

import 'package:FoodFacts/views/home.dart';
import 'package:FoodFacts/views/login.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());

    case LoginPageRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());

    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
