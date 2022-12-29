import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileUtility {
  static getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    final size = '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
    return;
  }

  static double getFileSizeInMB(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  // static Future<MediaInfo?> compressVideo(String videoPath) async {
  //   try {
  //     final thumbnailFile = await VideoCompress.compressVideo(videoPath,
  //         quality: VideoQuality.LowQuality,
  //         includeAudio: true,
  //         );
  //     return thumbnailFile;
  //   } catch (e) {
  //     AppLogger.e('Exception to compress video - ${e.toString()}');
  //     return null;
  //   }
  // }
  //
  // static Future<MediaInfo?> getVideoFileInfo(String videoPath) async {
  //   try {
  //     final mediaInfo = await VideoCompress.getMediaInfo(
  //       videoPath,
  //     );
  //     return mediaInfo;
  //   } catch (e) {
  //     AppLogger.e('Exception to get media info - ${e.toString()}');
  //     return null;
  //   }
  // }
  //
  // static Future<String?> getVideoByteThumb(String videoPath) async {
  //   try {
  //     final mediaInfo = await VideoCompress.getFileThumbnail(
  //       videoPath,
  //     );
  //     if(mediaInfo!=null){
  //        return ImageUtility.imageTo64(mediaInfo);
  //     }else{
  //       return null;
  //     }
  //   } catch (e) {
  //     AppLogger.e('Exception to get media info - ${e.toString()}');
  //     return null;
  //   }
  //
  // }

  static String? getNameFromURL(String? url) {
    if (url != null && url.isNotEmpty) {
      return path.basename(url);
    } else {
      return '';
    }
  }

  static String? getNameFromURLWithSkip(String? url) {
    if (url != null && url.isNotEmpty) {
      final name = path.basename(url);
      if (name.length < 5) {
        return name;
      }
      final names = name.split('.');
      return '${name.substring(0, 5)}.${names.last}';
    } else {
      return '';
    }
  }

  static Future<Directory?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      return null;
    }
    return directory;
  }
}
