import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomImageCacheManager extends CacheManager with ImageCacheManager {
  String key;
  CustomImageCacheManager({required this.key})
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 1),
          ),
        );

  Future<String> getPath(String url) {
    return getSingleFile(url).then((file) => file.path);
  }
}
