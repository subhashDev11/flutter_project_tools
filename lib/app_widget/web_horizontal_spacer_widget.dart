import 'package:flutter/material.dart';

class WebHorizontalSpacerWidget extends StatelessWidget {
  const WebHorizontalSpacerWidget({
    Key? key,
    required this.child,
    this.mainFlex,
    this.sideFlex,
    this.side1,
    this.side2,
  }) : super(key: key);

  final Widget child;
  final int? mainFlex;
  final int? sideFlex;
  final Widget? side1;
  final Widget? side2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: sideFlex ?? 1,
          child: side1 ?? const SizedBox(),
        ),
        Expanded(
          flex: mainFlex ?? 12,
          child: child,
        ),
        Expanded(
          flex: sideFlex ?? 1,
          child: side2 ?? const SizedBox(),
        )
      ],
    );
  }
}
