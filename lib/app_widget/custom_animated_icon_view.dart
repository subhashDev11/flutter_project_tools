import 'package:flutter/material.dart';

class CustomAnimatedIconWidget extends StatelessWidget {
  const CustomAnimatedIconWidget({
    Key? key,
    required this.showFirst,
    this.color,
    this.size,
    required this.icon1,
    required this.icon2,
  }) : super(key: key);

  final bool showFirst;
  final Color? color;
  final double? size;
  final IconData icon1;
  final IconData icon2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (child, anim) => RotationTransition(
        turns: child.key == const ValueKey('icon1')
            ? Tween<double>(begin: 1, end: 1).animate(anim)
            : Tween<double>(begin: 0.75, end: 1).animate(anim),
        child: ScaleTransition(scale: anim, child: child),
      ),
      child: showFirst
          ? Icon(
              icon1,
              key: const ValueKey('icon1'),
              color: color ?? theme.primaryColor,
              size: size ?? 30,
            )
          : Icon(
              icon2,
              key: const ValueKey('icon2'),
              color: color ?? theme.primaryColor,
              size: size ?? 30,
            ),
    );
  }
}
