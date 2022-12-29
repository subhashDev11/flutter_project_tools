import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.color,
    this.title,
    this.onTap,
    this.txtColor,
    this.enable,
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
    this.txtAlign,
    this.alignEnd,
  }) : super(key: key);

  final Color? color;
  final String? title;

  final VoidCallback? onTap;
  final Color? txtColor;
  final bool? enable;
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
  final bool? alignEnd;
  final TextAlign? txtAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleText = Center(
      child: AppText(
        title: title,
        txtAlign: txtAlign,
        style: titleStyle ??
            theme.textTheme.titleMedium?.copyWith(
             
              fontSize: fontSize ?? 17,
              fontWeight: fontWeight ?? FontWeight.w600,
              color: _getColor(context),
            ),
      ),
    );
    return InkWell(
      splashColor: theme.primaryColor.withOpacity(0.20),
      onTap: enable ?? true ? onTap : null,
      child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 10,
              ),
          child: child ?? getTitle(titleText, context)),
    );
  }

  Widget getTitle(Widget titleText, BuildContext context) {
    if (iconData != null) {
      return Row(
        mainAxisAlignment: alignEnd ?? false ? MainAxisAlignment.end : MainAxisAlignment.center,
        children: [
          titleText,
          const SizedBox(
            width: 10,
          ),
          Icon(
            iconData!,
            color: _getColor(context),
            size: 30,
          ),
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
    if (!(enable ?? true)) {
      return theme.colorScheme.secondary.withOpacity(0.5);
    }
    if (color != null) {
      return color;
    } else {
      return theme.colorScheme.secondary;
    }
  }
}
