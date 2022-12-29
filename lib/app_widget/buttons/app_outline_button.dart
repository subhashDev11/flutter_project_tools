import 'package:flutter/material.dart';
import 'package:flutter_project_tools/app_widget/app_widgets.dart';
import '../../common/shadow_child_view.dart';

class AppOutlineButton extends StatefulWidget {
  const AppOutlineButton({
    Key? key,
    this.onTap,
    required this.title,
    this.outlineBorderColor,
    this.withShadow,
    this.titleStyle,
    this.isEnabled,
    this.borderRadius,
    this.contentPadding,
    this.titleColor,
  }) : super(key: key);
  final String title;
  final VoidCallback? onTap;
  final Color? outlineBorderColor;
  final TextStyle? titleStyle;
  final bool? withShadow;
  final double? borderRadius;
  final bool? isEnabled;
  final EdgeInsets? contentPadding;
  final Color? titleColor;

  @override
  State<AppOutlineButton> createState() => _AppOutlineButtonState();
}

class _AppOutlineButtonState extends State<AppOutlineButton> {
  final _hoverChangeNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<bool>(
        valueListenable: _hoverChangeNotifier,
        builder: (context, hoverActive, child) {
          return MouseRegion(
            onEnter: (value) {
              _hoverChangeNotifier.value = true;
            },
            onExit: (value) {
              _hoverChangeNotifier.value = false;
            },
            child: GestureDetector(
              onTap: widget.isEnabled ?? true ? widget.onTap : null,
              child: widget.withShadow ?? false
                  ? Opacity(
                      opacity: widget.isEnabled ?? true ? 0.99 : 0.2,
                      child: ShadowChildView(
                        child: Container(
                          padding: widget.contentPadding ??
                              const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 25)),
                            border: Border.all(
                              color: widget.outlineBorderColor ?? theme.colorScheme.secondary,
                            ),
                            color: hoverActive ? theme.colorScheme.secondary : Colors.white,
                          ),
                          child: Center(
                            child: AppText(
                              title: widget.title,
                              style: widget.titleStyle ??
                                  theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        hoverActive ? Colors.white : widget.titleColor ?? theme.colorScheme.secondary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Opacity(
                      opacity: widget.isEnabled ?? true ? 0.99 : 0.2,
                      child: Container(
                        padding: widget.contentPadding ??
                            const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 25)),
                          border: Border.all(
                            color: widget.outlineBorderColor ?? theme.colorScheme.secondary,
                          ),
                          color: hoverActive ? theme.colorScheme.secondary : Colors.white,
                        ),
                        child: Center(
                          child: AppText(
                            title: widget.title,
                            style: widget.titleStyle ??
                                theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: hoverActive ? Colors.white : widget.titleColor ?? theme.colorScheme.secondary,
                                ),
                          ),
                        ),
                      ),
                    ),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _hoverChangeNotifier.dispose();
    super.dispose();
  }
}
