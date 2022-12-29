import 'package:flutter/material.dart';

import 'keyboard_dissmesser.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget desktop;
  final Widget? mobile;
  final Widget? tab;

  const ResponsiveWidget({
    Key? key,
    required this.desktop,
    this.mobile,
    this.tab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDissmiser(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return desktop;
          } else if (constraints.maxWidth <= 1200 &&
              constraints.maxWidth >= 800) {
            return desktop;
          } else if (constraints.maxWidth <= 800 &&
              constraints.maxWidth >= 600) {
            return tab ?? desktop;
          } else {
            return OrientationBuilder(
              builder: (_, orientation) {
                if (orientation == Orientation.landscape) {
                  return mobile ?? tab ?? desktop;
                } else {
                  return mobile ?? tab ?? desktop;
                }
              },
            );
          }
        },
      ),
    );
  }
}
