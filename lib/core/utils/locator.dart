import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tools/services/services.dart';
import 'package:get_it/get_it.dart';
import '../network/network_info.dart';

final injector = GetIt.instance;

void locator({required String baseURL, required GlobalKey<NavigatorState> navigatorKey}) {
  Connectivity connectivity = Connectivity();

  injector.registerSingleton<NavigationService>(NavigationService(navigatorKey));

  injector.registerSingleton<NetworkInfo>(NetworkInfo(connectivity));

  injector.registerSingleton<OverlayService>(OverlayService());

  injector.registerSingleton<ConnectivityService>(
    ConnectivityService('www.apple.com'),
  );

  injector.registerSingleton<AppStorageService>(
    AppStorageService(),
  );

  injector.registerSingleton<HttpService>(
    HttpService.instance(baseUrl: baseURL),
  );

  injector.registerSingleton<DownloadService>(
    MobileDownloadService(),
  );
}
