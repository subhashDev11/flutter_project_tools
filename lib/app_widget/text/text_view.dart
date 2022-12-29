import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    Key? key,
    this.title,
    this.style,
    this.txtAlign,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.fontStyle,
    this.letterSpacing,
    this.fontFamilyLevel,
    this.overflow,
    this.maxLine,
    this.decoration,
  }) : super(key: key);

  final String? title;
  final TextStyle? style;
  final TextAlign? txtAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final int? fontFamilyLevel;
  final TextOverflow? overflow;
  final int? maxLine;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title ?? '',
      textAlign: txtAlign ?? TextAlign.start,
      style: style ??
          theme.textTheme.titleMedium?.copyWith(
            fontFamily: getFont(),
            fontSize: fontSize ?? 17,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: fontColor,
            fontStyle: fontStyle ?? FontStyle.normal,
            letterSpacing: letterSpacing,
            decoration: decoration,
          ),
      overflow: overflow,
      maxLines: maxLine,
    );
  }

  String getFont() {
    switch (fontFamilyLevel) {
      case 1:
        return 'Roboto';
      case 2:
        return '';
      case 3:
        return 'century-gothic';
      default:
        return 'Roboto';
    }
  }
}

class AutoSizeAppText extends StatelessWidget {
  const AutoSizeAppText({
    Key? key,
    this.title,
    this.style,
    this.txtAlign,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.fontStyle,
    this.letterSpacing,
    this.overflow,
    required this.maxLine,
  }) : super(key: key);

  final String? title;
  final TextStyle? style;
  final TextAlign? txtAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoSizeText(
      title ?? '',
      textAlign: txtAlign ?? TextAlign.start,
      maxLines: maxLine,
      maxFontSize: 40,
      minFontSize: 5,
      style: style ??
          theme.textTheme.titleMedium?.copyWith(
            fontSize: fontSize ?? 17,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: fontColor,
            letterSpacing: letterSpacing,
          ),
      overflow: overflow,
    );
  }
}
