import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading(
      {Key? key,
      this.color = const AlwaysStoppedAnimation<Color>(Colors.blue),
      this.backgroundColor = Colors.white})
      : super(key: key);
  final AlwaysStoppedAnimation<Color> color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20),
        child: CircularProgressIndicator(
          value: .8,
          backgroundColor: backgroundColor,
          valueColor: color,
        ));
  }
}
