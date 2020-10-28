import 'package:flutter/material.dart';

class NutrimentsWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Color color;
  final String dataLabel;
  final double dataLabelSize;
  final FontWeight dataLabelWeight;
  final String dataValue;
  final double dataValueSize;
  final FontWeight dataValueWeight;

  NutrimentsWidget({
    this.padding,
    this.color,
    this.dataLabel,
    this.dataLabelSize,
    this.dataLabelWeight,
    this.dataValue,
    this.dataValueSize,
    this.dataValueWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: color,
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: dataLabel,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: dataLabelSize,
                    fontWeight: dataLabelWeight,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: dataValue,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: dataValueSize,
                    fontWeight: dataValueWeight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
