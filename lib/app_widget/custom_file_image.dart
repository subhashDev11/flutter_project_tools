import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomFileImage extends StatelessWidget {
  const CustomFileImage({
    Key? key,
    required this.url,
    required this.fit,
  }) : super(key: key);

  final String url;
  final BoxFit fit;

  Future<Uint8List?> getImageByte() async {
    try {
      final pickedFileBytes = await File(url).readAsBytes();
      return pickedFileBytes;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return FutureBuilder(
        future: getImageByte(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final imageData = snapshot.data;
            return Image.memory(
              imageData!,
              fit: BoxFit.cover,
            );
          } else {
            return const SizedBox(
              child: Text('whwhwhhw'),
            );
          }
        },
      );
    } else {
      return Image.file(
        File(url),
        fit: BoxFit.cover,
      );
    }
  }
}
