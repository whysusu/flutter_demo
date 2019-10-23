import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  BoldText(this.data);

  String data;

  @override
  Widget build(BuildContext context) {
    return _buildWigdet();
  }

  Widget _buildWigdet() {
    return Text(
      data,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
