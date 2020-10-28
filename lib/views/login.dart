import 'package:flutter/material.dart';

import 'package:FoodFacts/models/constants.dart';
import 'package:FoodFacts/services/authentication_service.dart';
import 'package:FoodFacts/widgets/login_fab_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 68),
            Image(
              image: AssetImage(
                'assets/food_facts_logo.png',
              ),
              height: 300,
            ),
            SizedBox(height: 80),
            FloatingActionButtonWidget(
              onTap: () {
                signInWithGoogle().then((result) {
                  if (result != null) {
                    Navigator.pushNamed(context, HomePageRoute);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
