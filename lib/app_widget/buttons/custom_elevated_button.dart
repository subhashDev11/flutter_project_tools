import 'package:flutter/material.dart';

class ElevationButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final double? height;
  final double? width;
  final bool? isSecondary;
  final String? text;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;

  const ElevationButtonWidget(
      {Key? key,
      this.textColor,
      this.borderColor,
      this.backgroundColor,
      this.isSecondary,
      this.height,
      this.width,
      this.onTap,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: height ?? 45,
        width: (width ?? 45) * 3,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor ?? theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: borderColor ?? theme.primaryColor,
              ),
            ),
          ),
          onPressed: onTap,
          child: Text(
            text ?? ((isSecondary ?? false) ? "CANCEL" : "SAVE"),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
