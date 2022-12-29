import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;

  const RichTextWidget({
    Key? key,
    this.title,
    this.subTitle,
    this.titleColor,
    this.subTitleColor,
    this.titleStyle,
    this.subTitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title ?? "",
              style: titleStyle ?? TextStyle(color: titleColor)),
          TextSpan(
            text: subTitle ?? "",
            style: subTitleStyle ??
                TextStyle(fontWeight: FontWeight.bold, color: subTitleColor),
          )
        ],
      ),
    );
  }
}
