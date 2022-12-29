import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.height,
    this.width,
    required this.iconPath,
  }) : super(key: key);

  final double? height;
  final double? width;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }
}
