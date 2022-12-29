import 'package:flutter/material.dart';

class DecoratedText extends StatelessWidget {
  const DecoratedText(
      {Key? key,
      required this.child,
      this.decorationColor,
      this.decorationWidth,
      this.spacing,
      this.style,
      this.alignment})
      : super(key: key);
  final Text child;
  final Color? decorationColor;
  final double? decorationWidth;
  final double? spacing;
  final TextStyle? style;
  final TextAlign? alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        right: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              child.data ?? '',
              textAlign: alignment,
              style: child.style?.copyWith(
                color: Colors.transparent,
                // Step 2 SEE HERE
                shadows: [
                  Shadow(
                      offset: const Offset(
                        0,
                        -5,
                      ),
                      color:
                          child.style?.color?.withOpacity(0.7) ?? Colors.black)
                ],
                // Step 3 SEE HERE
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationColor: child.style?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
