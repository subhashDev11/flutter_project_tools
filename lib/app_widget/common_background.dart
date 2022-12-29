import 'package:flutter/material.dart';

class CommonBackground extends StatelessWidget {
  final double? height;
  final double? radius;
  const CommonBackground({Key? key, this.height, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppBar().preferredSize.height + 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius ?? 20),
          bottomRight: Radius.circular(radius ?? 20),
        ),
      ),
    );
  }
}
