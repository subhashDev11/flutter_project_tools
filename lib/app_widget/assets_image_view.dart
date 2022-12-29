import 'package:flutter/material.dart';

class AssetImageView extends StatelessWidget {
  const AssetImageView(
      {Key? key, required this.path, this.width, this.height, this.fit})
      : super(key: key);

  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Image.asset(
          path,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
        ),
      ),
    );
  }
}
