import 'dart:async';
import 'package:flutter_project_tools/core/core.dart';
import 'package:flutter_project_tools/services/overlay_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService implements ConnectivityContract {
  final String _pingUrl;

  bool connected = true;

  ConnectivityService(this._pingUrl);

  init() {
    Connectivity().onConnectivityChanged.listen((event) {
      AppLogger.i('Connection state - ${event.name}');
      if (event == ConnectivityResult.none) {
        connected = false;
        noConnectionDialog();
      } else {
        connected = true;
      }
    });
  }

  void noConnectionDialog() async {
    await Future.delayed(const Duration(
      seconds: 2,
    ));
    if (!connected) {
      injector<OverlayService>().showAwesomeDialog(
        title: 'Internet connection not found',
        subTitle: 'Please make sure you have a internet connection',
        onPrimaryTap: () {},
      );
    }
  }

  @override
  Future<bool> hasInternetConnectivity() async {
    return Future.microtask(() => connected);
  }
}
