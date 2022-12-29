import 'package:flutter_project_tools/app_widget/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_tools/common/common_widgets.dart';

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({Key? key, required this.title, this.onTap}) : super(key: key);

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ScreenCard(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        elevation: 15,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: AppText(
                title: title,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
