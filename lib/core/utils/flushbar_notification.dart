import 'package:flutter/material.dart';

class FlushBarNotification {
  static showSnack(
    BuildContext context, {
    String? title,
    String? subTitle,
    Duration? duration,
    String? actionLabel,
    Color? actionLabelColor,
    VoidCallback? onTapAction,
  }) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            theme.brightness == ThemeMode.dark ? Colors.white : Colors.black,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.brightness == ThemeMode.dark
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              Visibility(
                visible: subTitle != null,
                child: const SizedBox(
                  height: 10,
                ),
              ),
              Visibility(
                visible: subTitle != null,
                child: Text(
                  subTitle ?? '',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.brightness == ThemeMode.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        action: SnackBarAction(
          label: actionLabel ?? '',
          onPressed: onTapAction ?? () {},
          textColor: actionLabelColor,
        ),
      ),
    );
  }
}
