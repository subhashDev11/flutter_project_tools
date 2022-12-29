import 'package:flutter/material.dart';
import 'package:flutter_project_tools/common/common_widgets.dart';

class RectangleIconTextButton extends StatelessWidget {
  const RectangleIconTextButton({
    Key? key,
    required this.buttonColor,
    this.titleColor,
    this.title,
    this.imageUrl,
    this.icon,
    this.onTap,
  }) : super(key: key);
  final Color buttonColor;
  final Color? titleColor;
  final String? title;
  final String? imageUrl;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ScreenCard(
        color: buttonColor,
        borderRadius: 30,
        withShadow: false,
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: imageUrl != null
              ? Image.asset(
                  imageUrl!,
                  height: 30,
                  width: 30,
                )
              : Icon(
                  icon,
                  color: titleColor ?? Colors.white,
                  size: 25,
                ),
        ),
      ),
    );
  }
}
