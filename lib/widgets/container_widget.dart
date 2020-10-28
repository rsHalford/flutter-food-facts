import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget child;

  ContainerWidget({
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue[900],
            offset: Offset(8, 8),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}
