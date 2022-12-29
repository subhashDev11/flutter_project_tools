import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  const ScreenContainer({
    Key? key,
    this.scaffoldKey,
    this.title,
    required this.child,
    this.subtitle,
    this.color,
    this.resizeToAvoidBottomPadding,
    this.padding = EdgeInsets.zero,
    this.safeAreaBottom = true,
    this.fab,
    this.fabLocation,
    this.actions,
    this.showAppBarBottomBorder = false,
    this.titleChild,
    this.toolbarHeight = kToolbarHeight,
    this.appBarElevation = 0,
    this.leading,
    this.showBackText = true,
    this.leadingCallBack,
    this.showAppBar = true,
    this.myAppBar,
    this.bottomSheet,
    this.showLeading = true,
    this.bottomAppBar,
    this.centerTitle = false,
    this.titleStyle,
    this.bigTitle = false,
    this.leadingWidth,
    this.navigationBar,
  }) : super(key: key);
  final Key? scaffoldKey;
  final Widget child;
  final Widget? titleChild;
  final String? title;
  final String? subtitle;
  final Color? color;
  final bool? resizeToAvoidBottomPadding;
  final EdgeInsetsGeometry padding;
  final bool safeAreaBottom;
  final bool showAppBarBottomBorder;
  final double? toolbarHeight;
  final Widget? fab;
  final FloatingActionButtonLocation? fabLocation;
  final List<Widget>? actions;
  final double appBarElevation;
  final Widget? leading;
  final VoidCallback? leadingCallBack;
  final bool showBackText;
  final bool showAppBar;
  final PreferredSize? myAppBar;
  final Widget? bottomSheet;
  final bool showLeading;
  final PreferredSizeWidget? bottomAppBar;
  final bool? centerTitle;
  final TextStyle? titleStyle;
  final bool? bigTitle;
  final double? leadingWidth;
  final Widget? navigationBar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
      backgroundColor: color ?? theme.scaffoldBackgroundColor,
      appBar: myAppBar ??
          (title != null && showAppBar
              ? AppBar(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  leadingWidth: leadingWidth ?? (showLeading ? 60 : 5),
                  titleSpacing: 0,
                  elevation: appBarElevation,
                  actionsIconTheme: IconThemeData(
                    color: theme.primaryColor,
                  ),
                  leading: leading ??
                      (showLeading
                          ? GestureDetector(
                              onTap: () {
                                if (leadingCallBack != null) {
                                  leadingCallBack!();
                                } else {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 20,
                                  )),
                            )
                          : null),
                  centerTitle: centerTitle,
                  toolbarHeight: toolbarHeight,
                  shape: showAppBarBottomBorder
                      ? const Border(
                          bottom: BorderSide(
                            color: Colors.black87,
                            width: 0.5,
                          ),
                        )
                      : null,
                  title: titleChild ??
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DefaultTextStyle.merge(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            child: Text(
                              title!,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: titleStyle ??
                                  theme.textTheme.titleLarge?.copyWith(
                                   
                                    fontSize: bigTitle ?? false ? 24 : 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          if (subtitle != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: DefaultTextStyle.merge(
                                style: const TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  height: 1.25,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                child: Text(subtitle!, style: theme.textTheme.titleSmall?.copyWith()),
                              ),
                            ),
                        ],
                      ),
                  actions: actions,
                  bottom: bottomAppBar,
                )
              : null),
      body: SafeArea(
        bottom: safeAreaBottom,
        child: KeyboardDissmiser(
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
      bottomSheet: bottomSheet != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: theme.scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: bottomSheet ?? const SizedBox(),
                ),
              ],
            )
          : null,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar: navigationBar,
    );
  }
}

class KeyboardDissmiser extends StatelessWidget {
  const KeyboardDissmiser({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (primaryFocus?.hasFocus ?? false) {
          primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
