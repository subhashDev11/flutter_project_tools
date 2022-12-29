import 'package:flutter/material.dart';

class CustomChipView extends StatelessWidget {
  const CustomChipView({Key? key, this.title, this.selected, this.onTap})
      : super(key: key);
  final String? title;
  final bool? selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25),
            color: selected ?? false ? theme.primaryColor : theme.cardColor,
            border: Border.all(
              color: theme.dividerColor,
            )),
        duration: const Duration(
          milliseconds: 300,
        ),
        child: Text(
          title ?? '',
          style: selected ?? false
              ? theme.textTheme.caption?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                )
              : theme.textTheme.caption?.copyWith(
                  fontSize: 16,
                ),
        ),
      ),
    );
  }
}
