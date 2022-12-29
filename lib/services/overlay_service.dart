import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tools/app_widget/app_widgets.dart';
import 'package:flutter_project_tools/common/common_widgets.dart';
import 'package:flutter_project_tools/core/app_enums.dart';
import 'package:flutter_project_tools/core/overlay.contract.dart';
import 'package:flutter_project_tools/flutter_project_tools.dart';
import '../core/helper/app_bottom_sheet.dart';
import '../core/utils/locator.dart';
import 'navigation_service.dart';

class OverlayService implements OverlayContract {
  @override
  void showSnackbar({
    String? message,
    String? title,
    SnackbarType alertType = SnackbarType.info,
    String? actionLabel,
    Function? callback,
    SnackbarPosition? position = SnackbarPosition.top,
  }) {
    Color bgColor;

    final navigationService = injector<NavigationService>();

    switch (alertType) {
      case SnackbarType.info:
        bgColor = Colors.black;
        break;
      case SnackbarType.success:
        bgColor = Colors.cyan.shade700;
        break;
      case SnackbarType.failed:
        bgColor = Colors.red.shade500;
        break;
    }

    ScaffoldMessenger.of(navigationService.navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: title != null,
              child: Text(
                title ?? '',
                style: Theme.of(navigationService.navigatorKey.currentState!.context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
            Visibility(
              visible: message != null,
              child: Text(
                message ?? '',
                style: Theme.of(navigationService.navigatorKey.currentState!.context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        action: callback != null
            ? SnackBarAction(
                label: actionLabel ?? 'Ok',
                onPressed: () => callback,
              )
            : SnackBarAction(
                label: 'Dismiss',
                textColor: Colors.yellow.shade700,
                onPressed: () {
                  ScaffoldMessenger.of(navigationService.navigatorKey.currentState!.context).hideCurrentSnackBar();
                },
              ),
        margin: const EdgeInsets.only(
          bottom: 20,
          left: 10,
          right: 10,
        ),
        padding: const EdgeInsets.all(10),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Future showModal(ModalType modal, {Map<String, dynamic>? arguments, String? title, String? subTitle}) async {
    final navigationService = injector<NavigationService>();

    switch (modal) {
      case ModalType.moduleProgressUpdate:
        return showDialog(
            context: navigationService.navigatorKey.currentState!.context,
            builder: (context) => ModuleCompletionPopup(
                  achived: 100,
                  initial: 50,
                  title: title,
                  subTitle: subTitle,
                ),
            useSafeArea: false);
      case ModalType.fullscreenImage:
        return showDialog(
            context: navigationService.navigatorKey.currentState!.context,
            builder: (context) => FullScreenImagePlayer(
                  image: arguments!['path'],
                ),
            useSafeArea: false);
      case ModalType.fullscreenVideo:
        showDialog(
            context: navigationService.navigatorKey.currentState!.context,
            builder: (context) => FullscreenPlayer(
                  path: arguments!['path'],
                ),
            useSafeArea: false);
        break;

      case ModalType.loading:
        showDialog(
          context: navigationService.navigatorKey.currentState!.context,
          builder: (context) => const CircularProgressIndicator(),
          useSafeArea: false,
          barrierDismissible: false,
        );
        break;
    }
  }

  @override
  Future<dynamic> showAwesomeDialog(
      {DialogType? dialogType,
      required Function() onPrimaryTap,
      String? title,
      String? subTitle,
      Function()? onSecondaryTap,
      String? secondaryText,
      String? primaryText,
      bool? dismissOnBackKeyPress}) async {
    final navigationService = injector<NavigationService>();
    await AwesomeDialog(
      context: navigationService.navigatorKey.currentState!.context,
      title: title,
      titleTextStyle: Theme.of(navigationService.navigatorKey.currentState!.context).textTheme.titleLarge,
      desc: subTitle,
      descTextStyle: Theme.of(navigationService.navigatorKey.currentState!.context).textTheme.titleSmall,
      dialogType: dialogType ?? DialogType.info,
      dismissOnTouchOutside: false,
      btnCancel: onSecondaryTap == null
          ? null
          : SecondaryButton(
              onTap: () {
                Navigator.of(navigationService.navigatorKey.currentState!.context).pop();
                onSecondaryTap();
              },
              title: secondaryText ?? 'Cancel',
              titleStyle: TextStyle(
                color: Theme.of(navigationService.navigatorKey.currentState!.context).primaryColor,
              ),
              radius: 6,
            ),
      btnOk: PrimaryButton(
        onTap: () {
          Navigator.of(navigationService.navigatorKey.currentState!.context).pop();
          onPrimaryTap();
        },
        radius: 6,
        child: Text(
          primaryText ?? "OK",
          textAlign: TextAlign.center,
        ),
      ),
      dismissOnBackKeyPress: dismissOnBackKeyPress ?? true,
    ).show();
  }

  @override
  Future appDialog(Widget content, {double? radius}) async {
    final navigationService = injector<NavigationService>();
    return await showDialog(
      context: navigationService.navigatorKey.currentState!.context,
      barrierDismissible: false,
      barrierLabel: '',
      builder: (_) {
        return NoPopWidget(
          child: DialogContent(
            content: content,
            radius: radius,
          ),
        );
      },
    );
  }

  @override
  Future appBottomSheet(Widget content, {double? radius}) async {
    final navigationService = injector<NavigationService>();
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: navigationService.navigatorKey.currentState!.context,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(navigationService.navigatorKey.currentState!.context).size.height * 0.7,
      ),
      builder: (BuildContext context) {
        return SheetContent(content: content);
      },
    );
  }
}

class NoPopWidget extends StatelessWidget {
  const NoPopWidget({Key? key, required this.child, this.futureTask}) : super(key: key);
  final Widget child;
  final Future<bool> Function()? futureTask;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        if (futureTask != null) {
          return await futureTask!();
        } else {
          return await Future.microtask(() => false);
        }
      },
    );
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({Key? key, required this.content, this.radius}) : super(key: key);
  final Widget content;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kIsWeb
            ? Content(
                radius: radius,
                child: content,
              )
            : Stack(
                children: [
                  ScreenCard(
                    color: Colors.white,
                    borderRadius: radius ?? 10,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.center,
                      child: content,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      type: MaterialType.circle,
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 25,
                          )),
                    ),
                  )
                ],
              ),
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key, required this.child, this.radius}) : super(key: key);
  final Widget child;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ScreenCard(
                color: Colors.white,
                borderRadius: radius ?? 10,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
