import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_tools/core/core.dart';
import 'package:flutter_svg/svg.dart';

import 'form_title.dart';

class TextFormWidget extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcons;
  final Widget? prefixIcon;
  final double? radius;
  final bool? isRequired;
  final String? titleText;
  final bool? isSearch;
  final bool? isReadOnly;
  final bool? requiredTitle;
  final bool? showHint;
  final Function()? onTap;
  final int? minLines;
  final TextInputType? inputType;
  final int? maxLength;
  final void Function(String)? onChanged;
  final TextStyle? textStyle;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? pattern;
  final List<TextInputFormatter>? inputFormatters;
  final bool? applyRegexOnKeyboard;
  final TextAlign? textAlign;
  final bool? withTitle;
  final String? initialTxt;
  final TextInputAction? textInputAction;
  final InputDecoration? decoration;
  final TextStyle? tittleStyle;
  final TextStyle? hintStyle;
  final String? prefixIconPath;
  final IconData? prefixIconData;
  final String? suffixIconPath;
  final IconData? suffixIconData;
  final bool? obsecureTxt;
  final bool? passwordField;
  final bool? emailText;
  final bool? collapsed;
  final bool? forDropdownRead;
  final bool? applyBorder;
  final int? characterLimit;
  final void Function(String?)? onSubmit;

  const TextFormWidget({
    Key? key,
    this.titleText,
    this.onChanged,
    this.textStyle,
    this.prefixIcon,
    this.onTap,
    this.isSearch = false,
    this.inputType,
    this.maxLength,
    this.isRequired,
    this.isReadOnly,
    this.minLines,
    this.hintText,
    this.radius,
    this.controller,
    this.validator,
    this.suffixIcons,
    this.pattern,
    this.inputFormatters,
    this.applyRegexOnKeyboard,
    this.textAlign,
    this.withTitle,
    this.initialTxt,
    this.textInputAction,
    this.decoration,
    this.tittleStyle,
    this.hintStyle,
    this.prefixIconPath,
    this.suffixIconPath,
    this.obsecureTxt,
    this.onSubmit,
    this.emailText,
    this.passwordField,
    this.forDropdownRead,
    this.collapsed,
    this.characterLimit,
    this.applyBorder,
    this.prefixIconData,
    this.suffixIconData,
    this.requiredTitle,
    this.showHint,
  }) : super(key: key);

  String? _initialText() {
    if (initialTxt != null) {
      return initialTxt;
    } else {
      return null;
    }
  }

  Key? _getKey() {
    if (initialTxt != null) {
      return Key(initialTxt.toString());
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        isSearch!
            ? Container()
            : Visibility(
                visible: withTitle ?? true,
                child: FormTitle(
                  isRequired: (isRequired ?? false) && !(isReadOnly ?? false) || (requiredTitle ?? false),
                  title: titleText ?? hintText ?? "",
                  style: tittleStyle ??
                      theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
        isSearch!
            ? Container()
            : const SizedBox(
                height: 10,
              ),
        forDropdownRead ?? false
            ? TextFormField(
                key: _getKey(),
                // <- Magic!
                initialValue: _initialText(),
                onFieldSubmitted: onSubmit,
                minLines: minLines,
                maxLines: (minLines ?? 0) + 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (st) {
                  if (validator != null) {
                    return validator!(st);
                  } else {
                    if (st == null && (isRequired ?? false)) {
                      return 'Filed required ';
                    } else if (st!.isEmpty && (isRequired ?? false)) {
                      return 'Filed required ';
                    } else {
                      return null;
                    }
                  }
                },
                maxLength: maxLength,
                controller: controller,
                obscureText: obsecureTxt ?? false,
                readOnly: isReadOnly ?? false,
                onTap: onTap,
                onChanged: onChanged,
                textAlign: textAlign ?? TextAlign.start,
                keyboardType: inputType,
                textInputAction: textInputAction ?? TextInputAction.next,
                style: textStyle ??
                    theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                decoration: decoration ??
                    InputDecoration(
                      counter: const SizedBox.shrink(),
                      errorMaxLines: 2,
                      suffixIcon: _getSuffix(),
                      prefixIcon: _getPrefix(),
                      suffixIconConstraints: _getSuffix() != null
                          ? const BoxConstraints(
                              maxWidth: 70,
                              maxHeight: 35,
                            )
                          : const BoxConstraints(
                              maxWidth: 0,
                              maxHeight: 0,
                            ),
                      prefixIconConstraints: _getPrefix() != null
                          ? const BoxConstraints(
                              maxWidth: 70,
                              maxHeight: 35,
                            )
                          : const BoxConstraints(
                              maxWidth: 0,
                              maxHeight: 0,
                            ),
                      isDense: true,
                      border: _getBorder(),
                      fillColor: _getFillColor(),
                      hintText: _getHint(),
                      filled: false,
                      hintStyle: hintStyle ??
                          theme.textTheme.titleMedium?.copyWith(
                           
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                      contentPadding: getPadding(),
                    ),
              )
            : TextFormField(
                initialValue: _initialText(),
                onFieldSubmitted: onSubmit,
                minLines: minLines,
                maxLines: (minLines ?? 0) + 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (st) {
                  if (validator != null) {
                    return validator!(st);
                  } else {
                    if (st == null && (isRequired ?? false)) {
                      return 'Filed required ';
                    } else if (st!.isEmpty && (isRequired ?? false)) {
                      return 'Filed required ';
                    } else {
                      return null;
                    }
                  }
                },
                maxLength: maxLength,
                controller: controller,
                obscureText: obsecureTxt ?? false,
                readOnly: isReadOnly ?? false,
                onTap: onTap,
                onChanged: onChanged,
                textAlign: textAlign ?? TextAlign.start,
                keyboardType: inputType,
                textInputAction: textInputAction ?? TextInputAction.next,
                inputFormatters: _getFormatter(),
                style: textStyle ??
                    theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                decoration: decoration ??
                    InputDecoration(
                      counterText: "",
                      errorMaxLines: 2,
                      suffixIcon: _getSuffix(),
                      prefixIcon: _getPrefix(),
                      suffixIconConstraints: _getSuffix() != null
                          ? const BoxConstraints(
                              maxWidth: 70,
                              maxHeight: 35,
                            )
                          : const BoxConstraints(
                              maxWidth: 0,
                              maxHeight: 0,
                            ),
                      prefixIconConstraints: _getPrefix() != null
                          ? const BoxConstraints(
                              maxWidth: 70,
                              maxHeight: 35,
                            )
                          : const BoxConstraints(
                              maxWidth: 0,
                              maxHeight: 0,
                            ),
                      isDense: true,
                      border: isReadOnly ?? false
                          ? InputBorder.none
                          : OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(
                                radius ?? 5,
                              ),
                            ),
                      fillColor: _getFillColor(),
                      hintText: _getHint(),
                      filled: false,
                      hintStyle: hintStyle ??
                          theme.textTheme.caption?.copyWith(
                           
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            //color: ColorConstants.textSubtitleColor,
                          ),
                      contentPadding: isReadOnly ?? false
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 20,
                            ),
                    ),
              ),
      ],
    );
  }

  InputBorder _getBorder() {
    if (applyBorder ?? false) {
      return OutlineInputBorder(
        borderSide: const BorderSide(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(
          radius ?? 5,
        ),
      );
    } else {
      if (isReadOnly ?? false) {
        return InputBorder.none;
      }
      return OutlineInputBorder(
        borderSide: const BorderSide(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(
          radius ?? 5,
        ),
      );
    }
  }

  _getFillColor() {
    if (isReadOnly ?? false) {
      if (onTap == null) {
        return Colors.white70;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }

  Widget? _getPrefix() {
    if (prefixIcon != null) () => prefixIcon;
    if (prefixIconPath != null) {
      () => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: _prefixIconWidget(),
          );
    }
    return null;
  }

  Widget? _getSuffix() {
    return Visibility(
      visible: suffixIcons != null || suffixIconData != null,
      replacement: const SizedBox.shrink(),
      child: suffixIcons ??
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: suffixIconPath != null || suffixIconData != null ? _suffixIconWidget() : const SizedBox(),
          ),
    );
  }

  Widget _prefixIconWidget() {
    if (prefixIconData != null) {
      return Icon(
        prefixIconData,
        size: 25,
      );
    } else {
      return SvgPicture.asset(
        prefixIconPath!,
        height: 25,
        width: 25,
      );
    }
  }

  Widget _suffixIconWidget() {
    if (suffixIconData != null) {
      return Icon(
        suffixIconData,
        size: 25,
      );
    } else {
      return SvgPicture.asset(
        suffixIconPath!,
        height: 25,
        width: 25,
      );
    }
  }

  List<TextInputFormatter> _getFormatter() {
    final list = <TextInputFormatter>[
      FilteringTextInputFormatter.deny(RegExp(Constants.emojiDisableRegex)),
    ];
    if (characterLimit != null) {
      list.add(LengthLimitingTextInputFormatter(characterLimit!));
    }
    return list;
  }

  EdgeInsets? getPadding() {
    if ((collapsed ?? false || (isReadOnly ?? false)) && !(applyBorder ?? false)) {
      return const EdgeInsets.all(0);
    } else {
      return const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      );
    }
  }

  String? _getHint() {
    if ((isReadOnly ?? false) && !(showHint ?? false)) {
      return null;
    } else {
      return hintText;
    }
  }
}
