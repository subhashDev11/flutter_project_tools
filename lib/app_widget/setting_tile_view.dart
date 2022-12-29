import 'package:flutter_project_tools/app_widget/app_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class SettingTileView extends StatelessWidget {
  const SettingTileView({
    Key? key,
    this.iconUrl,
    required this.title,
    this.count,
    this.onTap,
    this.iconData,
    this.style,
  }) : super(key: key);
  final String? iconUrl;
  final String title;
  final int? count;
  final VoidCallback? onTap;
  final IconData? iconData;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap ?? () {},
            splashColor: theme.primaryColor.withOpacity(0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconData != null && iconUrl == null
                    ? Icon(
                        iconData,
                      )
                    : iconUrl != null
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              iconUrl!,
                              fit: BoxFit.contain,
                            ),
                          )
                        : const SizedBox(),
                const SizedBox(
                  width: 15,
                ),
                AppText(
                  title: title,
                  style: style,
                ),
                const SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: count != null,
                  child: Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Divider(
              height: 2,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
