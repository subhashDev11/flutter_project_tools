import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_project_tools/core/core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'overlay_service.dart';
import 'package:universal_html/html.dart' as html;
import 'package:dio/dio.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

abstract class DownloadService {
  Future<void> download({required String url, required String token,required String appName});
}

class WebDownloadService implements DownloadService {
  @override
  Future<void> download({required String url, required String token,required String appName}) async {
    html.window.open(url, "_blank");
  }
}

class MobileDownloadService implements DownloadService {
  @override
  Future<void> download({required String url, required String token,required String appName}) async {

    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) {
      return;
    }

    Dio dio = Dio();
    Directory dir = await FileUtility.getDownloadPath() ?? await getApplicationDocumentsDirectory();

    String fileName = path.basename(url);
    try {
      await dio.download(url, "${dir.path}/$fileName", onReceiveProgress: (received, total) {
        if (total != -1) {
          AppLogger.i("Downloading url - $url status - ${(received / total * 100).toStringAsFixed(0)}%");
          _showProgressNotification((received / total * 100).toInt(), "${dir.path}/$fileName",appName);
        }
      });
      injector<OverlayService>().showAwesomeDialog(
        onPrimaryTap: () {
          OpenFilex.open(
            "${dir.path}/$fileName",
          );
        },
        title: 'File downloaded successfully in downloads!',
        subTitle: 'Preview now',
        dialogType: DialogType.success,
      );
    } catch (e) {
      injector<OverlayService>().showAwesomeDialog(
        onPrimaryTap: () {},
        title: 'File download error!',
        subTitle: 'Server denied access',
        dialogType: DialogType.error,
      );
    }
  }

  Future<int?> getAndroidVersion() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release = androidInfo.version.release;
    var sdkInt = androidInfo.version.sdkInt;
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;
    AppLogger.i('Android $release (SDK $sdkInt), $manufacturer $model');
    return int.tryParse(release);
    // if (Platform.isIOS) {
    //   var iosInfo = await DeviceInfoPlugin().iosInfo;
    //   var systemName = iosInfo.systemName;
    //   var version = iosInfo.systemVersion;
    //   var name = iosInfo.name;
    //   var model = iosInfo.model;
    //   AppLogger.i('$systemName $version, $name $model');
    // }
  }

  Future<bool> _requestWritePermission() async {

    if (Platform.isAndroid) {
      int version = await getAndroidVersion() ?? 10;
      if (version >= 12) {
        bool value = await Permission.manageExternalStorage.request().isGranted;
        if (!value) {
          await Permission.manageExternalStorage.request();
          value = await Permission.manageExternalStorage.request().isGranted;
        }
        return value;
      } else {
        bool value = await Permission.storage.request().isGranted;
        if (!value) {
          if (await Permission.storage.isPermanentlyDenied) {
            injector<OverlayService>().showAwesomeDialog(
                title: 'Storage Permission',
                subTitle: 'Please give storage permission from app setting',
                dialogType: DialogType.error,
                onPrimaryTap: () {
                  openAppSettings();
                });
          }
          await Permission.storage.request();
          value = await Permission.storage.request().isGranted;
        }
        return value;
      }
    } else {
      bool value = await Permission.storage.request().isGranted;
      if (!value) {
        await Permission.storage.request();
        value = await Permission.storage.request().isGranted;
      }
      return value;
    }
  }

  Future<void> _showProgressNotification(int progress, String filePath,String appName) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'bandhan $filePath',
      'Bandhan',
      channelDescription: 'Downloading file',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: progress != 100,
      maxProgress: progress,
      progress: progress,
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      appName,
      progress == 100 ? "Downloaded file - ${path.basename(filePath)}" : 'File Download - in Downloads',
      platformChannelSpecifics,
      payload: filePath,
    );
    // });
  }
}
