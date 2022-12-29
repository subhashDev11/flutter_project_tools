import 'package:flutter/material.dart';
import 'package:flutter_project_tools/app_widget/app_widgets.dart';

class BottomButtonView extends StatelessWidget {
  const BottomButtonView({Key? key, required this.enabled, this.title, this.onTap}) : super(key: key);

  final bool enabled;
  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 15,
          ),
          child: PrimaryButton(
            title: title ?? '',
            onTap: onTap,
            isDisabled: !enabled,
          ),
        ),
      ],
    );
  }
}
