import 'package:flutter/material.dart';

class BulletText extends StatelessWidget {
  const BulletText({
    this.bullet,
    required this.text,
    this.withBullet,
    this.textStyle,
    this.bulletColor,
    Key? key,
  }) : super(key: key);
  final IconData? bullet;
  final String text;
  final bool? withBullet;
  final TextStyle? textStyle;
  final Color? bulletColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: withBullet ?? false,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 6, right: 4),
            child: Icon(
              bullet ?? Icons.circle,
              size: 8,
              color: bulletColor ?? theme.textTheme.titleMedium?.color,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            text,
            style: textStyle ??
                theme.textTheme.titleMedium
                    ?.copyWith(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
