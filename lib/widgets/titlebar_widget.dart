import 'package:flutter/material.dart';

class TitleBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            top: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Food',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'Facts',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.blue[900],
                size: 30,
              ),
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'FoodFacts',
                  applicationVersion: '1.0.0',
                  applicationIcon: Image(
                    image: AssetImage('assets/food_facts_logo.png'),
                    height: 60,
                    width: 60,
                  ),
                  children: <Widget>[
                    Text(
                      'Warning:',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'The information and data is provided only for indicative information.\nIt can contain errors and must not be used for medical purposes.',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
