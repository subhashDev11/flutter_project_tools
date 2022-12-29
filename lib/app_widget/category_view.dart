import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.onTap,
    required this.imgPath,
    required this.menuLabel,
    this.size,
  }) : super(key: key);
  final String imgPath;
  final double? size;
  final String menuLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 6.00,
          bottom: 5.00,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.00,
                right: 7.26,
              ),
              child: SvgPicture.asset(
                imgPath,
                color: theme.primaryColor,
                height: size ?? 30,
                width: size ?? 30,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Text(
                  menuLabel,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
