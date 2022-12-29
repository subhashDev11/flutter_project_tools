import 'package:flutter/material.dart';
import 'package:flutter_project_tools/app_widget/app_widgets.dart';

class NoContentFound extends StatelessWidget {
  const NoContentFound({
    Key? key,
    this.center,
    this.title,
    this.content,
    this.onTap,
    this.buttonTitle, this.assetImageUrl,
  }) : super(key: key);

  final bool? center;
  final String? title;
  final String? content;
  final VoidCallback? onTap;
  final String? buttonTitle;
  final String? assetImageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: width * 0.7,
              width: width * 0.7,
              child: Image.asset(
                assetImageUrl ?? 'assets/content_not_found.png',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.00,
              ),
              child: Text(
                title ?? 'Content not found!',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Text(
                  content ?? '',
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
            Visibility(
              visible: title != null,
              child: PrimaryButton(
                title: buttonTitle,
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
