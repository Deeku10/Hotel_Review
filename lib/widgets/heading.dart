import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({Key? key, required this.t, required this.text})
      : super(key: key);

  final ThemeData t;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: t.textTheme.headline1,
        ),
      ],
    );
  }
}
