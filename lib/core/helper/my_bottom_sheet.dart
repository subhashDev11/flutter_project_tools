import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyBottomSheet {
  static void showImagePickerBottomSheet(BuildContext context,
      {Function(String?)? onGalleryTap, Function(String?)? onCameraTap}) {
    void pop(BuildContext context) {
      Navigator.of(context).pop();
    }

    showModalBottomSheet(
      context: context,
      builder: (_) {
        ImagePicker picker = ImagePicker();
        return SafeArea(
          child: Wrap(
            children: [
              Visibility(
                visible: !kIsWeb,
                child: ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(_);
                    XFile? file =
                        await picker.pickImage(source: ImageSource.camera);
                    if (onCameraTap != null) onCameraTap(file?.path);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(_);
                  XFile? file =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (onGalleryTap != null) onGalleryTap(file?.path);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
