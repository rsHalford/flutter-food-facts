import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final GestureTapCallback onTap;

  FloatingActionButtonWidget({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 55,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue[900],
                offset: Offset(8, 8),
              ),
            ],
          ),
        ),
        Material(
          child: InkWell(
            splashColor: Colors.blue[300],
            child: Container(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage(
                      'assets/google_logo.png',
                    ),
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              onTap();
            },
          ),
        ),
      ],
    );
  }
}
