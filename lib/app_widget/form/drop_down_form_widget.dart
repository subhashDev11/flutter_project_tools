import 'package:flutter/material.dart';
import '../app_widgets.dart';

class DropDownFormWidget extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcons;
  final Widget? prefixIcon;
  final double? radius;
  final bool? isRequired;
  final String? titleText;
  final bool? isSearch;
  final bool? isReadOnly;
  final Function()? onTap;
  final int? minLines;
  final TextInputType? inputType;
  final int? maxLength;
  final void Function(String?)? onChanged;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<String> items;
  final InputDecoration? customDecoration;
  final String? pattern;

  const DropDownFormWidget({
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
    required this.items,
    this.customDecoration,
    this.pattern,
    this.titleStyle,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        isSearch!
            ? Container()
            : FormTitle(
                isRequired: isRequired ?? false,
                title: titleText ?? hintText ?? "",
                style: titleStyle ??
                    theme.textTheme.titleMedium?.copyWith(
                     
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
        isSearch!
            ? Container()
            : const SizedBox(
                height: 10,
              ),
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              onChanged: onChanged ?? (st) {},
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (st) {
                if (validator != null) {
                  return validator!(st.toString());
                } else {
                  if (st == null && (isRequired ?? false)) {
                    return 'Filed required ';
                  } else if (st.toString().isEmpty && (isRequired ?? false)) {
                    return 'Filed required ';
                  } else {
                    if (pattern != null) {
                      if (!RegExp(pattern!).hasMatch((st ?? "").toString().toLowerCase())) {
                        return "Invalid input";
                      }
                    }
                    return null;
                  }
                }
              },
              icon: Center(
                child: suffixIcons ??
                    const Icon(
                      Icons.keyboard_arrow_down,
                    ),
              ),
              isDense: true,
              decoration: customDecoration ??
                  InputDecoration(
                    counterText: "",
                    prefixIcon: prefixIcon,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        radius ?? 25,
                      ),
                    ),
                    fillColor: isReadOnly ?? false ? Colors.white70 : Colors.white,
                    hintText: hintText ?? 'Select',
                    isDense: true,
                    filled: false,
                    hintStyle: hintStyle ??
                        theme.textTheme.caption?.copyWith(
                         
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                  ),
              items: items.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              style: textStyle ?? theme.textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
