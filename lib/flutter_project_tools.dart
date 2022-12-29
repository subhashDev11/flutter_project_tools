library flutter_project_tools;

import 'package:flutter/material.dart';
import 'package:flutter_project_tools/core/utils/locator.dart';
import 'package:flutter_project_tools/services/services.dart';

class FlutterProjectTools {
  FlutterProjectTools.instance(this.baseURL, this.navigatorKey) {
    initialize();
  }

  bool initialized = false;

  final String baseURL;
  final GlobalKey<NavigatorState> navigatorKey;

  void initialize() {
    if (!initialized) {
      locator(
        baseURL: baseURL,
        navigatorKey: navigatorKey,
      );
      initialized = true;
    }
  }

  OverlayService get overlayService {
    if (!initialized) {
      locator(
        baseURL: baseURL,
        navigatorKey: navigatorKey,
      );
    }
    return injector<OverlayService>();
  }

  NavigationService get navigationService {
    if (!initialized) {
      locator(
        baseURL: baseURL,
        navigatorKey: navigatorKey,
      );
    }
    return injector<NavigationService>();
  }

  AppStorageService get storageService {
    if (!initialized) {
      locator(
        baseURL: baseURL,
        navigatorKey: navigatorKey,
      );
    }
    return injector<AppStorageService>();
  }

  ConnectivityService get connectivityService {
    if (!initialized) {
      locator(
        baseURL: baseURL,
        navigatorKey: navigatorKey,
      );
    }
    return injector<ConnectivityService>().init();
  }

  DownloadService get downloadService {
    if (!initialized) {
      locator(
        baseURL: baseURL,
        navigatorKey: navigatorKey,
      );
    }
    return injector<DownloadService>();
  }

  HttpService get httpService {
    if (!initialized) {
      locator(
        baseURL: baseURL,
        navigatorKey: navigatorKey,
      );
    }
    return injector<HttpService>();
  }
}
