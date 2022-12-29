import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final TextStyle? style;
  final bool? isCenter;
  const FormTitle(
      {Key? key,
      this.title,
      this.isRequired = false,
      this.style,
      this.isCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: (isCenter ?? false)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: style ??
              theme.textTheme.caption?.copyWith(
               
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          isRequired ? " *" : '',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
