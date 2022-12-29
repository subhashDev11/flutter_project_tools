import 'package:flutter_project_tools/app_widget/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({Key? key, this.message, this.animatted}) : super(key: key);

  final String? message;
  final bool? animatted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: message != null,
          child: AppText(
            title: message,
            fontColor: Theme.of(context).colorScheme.secondary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Center(
          child:
              // (animatted ?? false)
              //     ? Column(
              //         children: [
              //           Lottie.asset(
              //             "assets/animations/cloud-downloading.json",
              //             width: double.infinity,
              //           ),
              //           const SizedBox(
              //             height: 20,
              //           ),
              //           const AppText(
              //             title: 'Loading...',
              //           ),
              //         ],
              //       )
              //     :
              CupertinoActivityIndicator(
            color: Theme.of(context).colorScheme.secondary,
            radius: 25,
            animating: true,
          ),
        ),
      ],
    );
  }
}
