// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';

extension MediaQueryValue on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

// ignore: camel_case_types
class horizontalspacer extends StatelessWidget {
  const horizontalspacer({
    Key? key,
    required this.w,
  }) : super(key: key);

  final double w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
    );
  }
}

// ignore: camel_case_types
class verticalspacer extends StatelessWidget {
  const verticalspacer({
    Key? key,
    required this.h,
  }) : super(key: key);

  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
    );
  }
}
