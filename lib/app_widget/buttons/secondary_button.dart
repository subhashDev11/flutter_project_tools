import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app_widgets.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    this.color,
    this.title,
    this.onTap,
    this.txtColor,
    this.isDisabled,
    this.buttonWithTxtField,
    this.child,
    this.radius,
    this.titleStyle,
    this.fontWeight,
    this.fontSize,
    this.titleColor,
    this.iconData,
    this.imgSource,
    this.padding,
  }) : super(key: key);

  final Color? color;
  final String? title;

  final VoidCallback? onTap;
  final Color? txtColor;
  final bool? isDisabled;
  final bool? buttonWithTxtField;
  final Widget? child;
  final double? radius;
  final TextStyle? titleStyle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? titleColor;
  final IconData? iconData;
  final String? imgSource;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleText = Center(
      child: AppText(
        title: title,
        txtAlign: TextAlign.center,
        style: titleStyle ??
            theme.textTheme.titleMedium?.copyWith(
             
              fontSize: fontSize ?? 17,
              fontWeight: fontWeight ?? FontWeight.w700,
            ),
      ),
    );
    return InkWell(
      splashColor: theme.primaryColor.withOpacity(0.20),
      onTap: isDisabled ?? false ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                radius ?? 25,
              ),
            ),
            border: Border.all(
              color: _getColor(context) ?? theme.dividerColor,
            )),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 13,
            ),
        child: child ?? getTitle(titleText),
      ),
    );
  }

  Widget getTitle(Widget titleText) {
    if (iconData != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleText,
          const SizedBox(
            width: 10,
          ),
          Icon(iconData!),
        ],
      );
    } else if (imgSource != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleText,
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            imgSource!,
            height: 20,
            width: 20,
          ),
        ],
      );
    } else {
      return titleText;
    }
  }

  Color? _getColor(BuildContext context) {
    final theme = Theme.of(context);
    if (isDisabled ?? false) {
      return theme.colorScheme.secondary;
    }
    if (color != null) {
      return color;
    } else {
      return theme.primaryColor;
    }
  }
}
