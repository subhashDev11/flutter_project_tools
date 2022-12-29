import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

enum SnackbarType { info, success, failed }

enum ModalType { moduleProgressUpdate, fullscreenVideo, loading, fullscreenImage }

abstract class OverlayContract {
  void showSnackbar(
      {String message, SnackbarType alertType = SnackbarType.info, String actionLabel, Function callback});
  Future showModal(ModalType modal, {Map<String, dynamic> arguments});

  Future<void> showAwesomeDialog(
      {DialogType? dialogType,
      required Function() onPrimaryTap,
      String? title,
      Function()? onSecondaryTap,
      String? secondaryText,
      String? primaryText,
      bool? dismissOnBackKeyPress});

  Future<dynamic> appDialog(Widget content, {double? radius});

  Future<dynamic> appBottomSheet(Widget content, {double? radius});
}
