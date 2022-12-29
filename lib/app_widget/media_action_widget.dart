import 'package:flutter/material.dart';

class ImageActionWidget extends StatelessWidget {
  const ImageActionWidget(
      {Key? key, this.actionIcon, required this.actionTitle, this.onTap})
      : super(key: key);
  final IconData? actionIcon;
  final String actionTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 13, 25, 1),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                actionIcon ?? Icons.delete_outline,
                color: Colors.white,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  actionTitle,
                  style: theme.textTheme.caption?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
