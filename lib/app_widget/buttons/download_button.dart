import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tools/services/services.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({Key? key, required this.url, required this.token, required this.appName}) : super(key: key);

  final String url;
  final String token;
  final String appName;

  Future<void> _downloadFile() async {
    DownloadService downloadService = kIsWeb ? WebDownloadService() : MobileDownloadService();
    await downloadService.download(url: url, token: token,appName: appName);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _downloadFile,
      icon: Icon(
        Icons.download,
        size: 35,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
