import 'package:flutter/material.dart';

class KeyboardDissmiser extends StatelessWidget {
  const KeyboardDissmiser({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (primaryFocus?.hasFocus ?? false) {
          primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
