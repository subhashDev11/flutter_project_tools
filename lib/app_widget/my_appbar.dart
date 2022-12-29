// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'app_widgets.dart';
//
// class DashboardAppBar extends StatelessWidget {
//   const DashboardAppBar({Key? key, this.title, this.actions, this.centerTitle}) : super(key: key);
//   final String? title;
//   final List<Widget>? actions;
//   final bool? centerTitle;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       actions: actions ??
//           [
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   barrierColor: Theme.of(context).primaryColorLight,
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (_) => StatefulBuilder(builder: (context, setState) {
//                     return HomeFilterSheet(
//                       onChanged: (b, index) {
//                         if (b != null) {
//                           controller.filterList[index ?? 0]['checked'] = b;
//                           setState(() {});
//                         }
//                       },
//                     );
//                   }),
//                 );
//               },
//               child: Image.asset('assets/images/filter_icon.png'),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   const Icon(
//                     Icons.refresh,
//                     size: 30,
//                   ),
//                   Positioned(
//                     top: 15,
//                     child: Obx(
//                       () => Container(
//                         height: 7,
//                         width: 7,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: CommonController.instance.isConnected.value
//                               ? ColorConstants.greenText
//                               : ColorConstants.redText,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: GestureDetector(
//                 onTap: () {
//                   //TODO: myProfileScreen
//                   Navigator.pushNamed(context, RouteNames.myProfileScreen);
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: ColorConstants.white,
//                   radius: 25,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: CachedNetworkImage(
//                       fit: BoxFit.fill,
//                       imageUrl: "",
//                       errorWidget: (_, st, d) => Image.asset('assets/images/dummy_man.png'),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//       title: Text(
//         title ?? '',
//         style: const TextStyle(
//           fontSize: 24,
//           color: Colors.white,
//         ),
//       ),
//       centerTitle: centerTitle ?? true,
//       // actions: actions ??
//       //     [
//       //       GestureDetector(
//       //         onTap: () {
//       //           showModalBottomSheet(
//       //             barrierColor: Theme.of(context).primaryColorLight,
//       //             context: context,
//       //             builder: (_) => StatefulBuilder(builder: (context, setState) {
//       //               return HomeFilterSheet(
//       //                 onChanged: (b, index) {
//       //                   if (b != null) {
//       //                     controller.filterList[index ?? 0]['checked'] = b;
//       //                     setState(() {});
//       //                   }
//       //                 },
//       //               );
//       //             }),
//       //           );
//       //         },
//       //         child: Image.asset('assets/images/filter_icon.png'),
//       //       ),
//       //       GestureDetector(
//       //         onTap: () {},
//       //         child: Stack(
//       //           alignment: Alignment.center,
//       //           children: [
//       //             const Icon(
//       //               Icons.refresh,
//       //               size: 30,
//       //             ),
//       //             Positioned(
//       //               top: 15,
//       //               child: Container(
//       //                 height: 7,
//       //                 width: 7,
//       //                 decoration: const BoxDecoration(
//       //                     shape: BoxShape.circle, color: ColorConstants.greenText),
//       //               ),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       const SizedBox(
//       //         width: 10,
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.only(right: 20),
//       //         child: GestureDetector(
//       //           onTap: () {},
//       //           child: CircleAvatar(
//       //             backgroundColor: ColorConstants.white,
//       //             radius: 25,
//       //             child: ClipRRect(
//       //               borderRadius: BorderRadius.circular(25),
//       //               child: CachedNetworkImage(
//       //                 fit: BoxFit.fill,
//       //                 imageUrl: "",
//       //                 errorWidget: (_, st, d) =>
//       //                     Image.asset('assets/images/dummy_man.png'),
//       //               ),
//       //             ),
//       //           ),
//       //         ),
//       //       )
//       //     ],
//     );
//   }
// }
//
// class DashboardWebAppBar extends StatelessWidget {
//   const DashboardWebAppBar({Key? key, this.title, this.actions, this.centerTitle}) : super(key: key);
//   final String? title;
//   final List<Widget>? actions;
//   final bool? centerTitle;
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = HomeController.instance;
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       actions: actions ??
//           [
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   barrierColor: Theme.of(context).primaryColorLight,
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (_) => StatefulBuilder(builder: (context, setState) {
//                     return HomeFilterSheet(
//                       onChanged: (b, index) {
//                         if (b != null) {
//                           controller.filterList[index ?? 0]['checked'] = b;
//                           setState(() {});
//                         }
//                       },
//                     );
//                   }),
//                 );
//               },
//               child: Image.asset(
//                 'assets/images/filter_icon.png',
//                 color: Colors.black,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   const Icon(
//                     Icons.refresh,
//                     size: 30,
//                     color: Colors.black,
//                   ),
//                   Positioned(
//                     top: 15,
//                     child: Obx(
//                       () => Container(
//                         height: 7,
//                         width: 7,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: CommonController.instance.isConnected.value
//                               ? ColorConstants.greenText
//                               : ColorConstants.redText,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: GestureDetector(
//                 onTap: () {
//                   //TODO: myProfileScreen
//                   Navigator.pushNamed(context, RouteNames.myProfileScreen);
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: ColorConstants.white,
//                   radius: 25,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: CachedNetworkImage(
//                       fit: BoxFit.fill,
//                       imageUrl: "",
//                       errorWidget: (_, st, d) => Image.asset('assets/images/dummy_man.png'),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//       title: Text(
//         title ?? '',
//         style: const TextStyle(
//           fontSize: 24,
//           color: Colors.white,
//         ),
//       ),
//       centerTitle: centerTitle ?? true,
//       leadingWidth: 0,
//       leading: const SizedBox(),
//     );
//   }
// }
//
// class GeneralAppBar extends StatelessWidget with PreferredSizeWidget {
//   const GeneralAppBar({
//     Key? key,
//     this.title,
//     this.actions,
//     this.centerTitle,
//     this.onTapBack,
//     this.leading = const Icon(
//       Icons.arrow_back,
//       color: ColorConstants.white,
//     ),
//     this.showLeading,
//     this.subTitle,
//     this.myToolbarHeight,
//     this.bottomBar,
//   }) : super(key: key);
//   final String? title;
//   final List<Widget>? actions;
//   final bool? centerTitle;
//   final Widget leading;
//   final Widget? subTitle;
//   final Function()? onTapBack;
//   final bool? showLeading;
//   final double? myToolbarHeight;
//   final PreferredSizeWidget? bottomBar;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: showLeading ?? true
//           ? GestureDetector(
//               onTap: onTapBack ??
//                   () {
//                     Navigator.pop(context);
//                   },
//               child: leading)
//           : const SizedBox(),
//       elevation: 0,
//       bottom: bottomBar,
//       shape: bottomBar != null
//           ? null
//           : const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//             ),
//       backgroundColor: Theme.of(context).primaryColor,
//       title: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title ?? '',
//             style: const TextStyle(
//               fontSize: 24,
//               color: Colors.white,
//             ),
//           ),
//           subTitle ?? const SizedBox(),
//         ],
//       ),
//       centerTitle: centerTitle ?? true,
//       actions: actions,
//       toolbarHeight: myToolbarHeight ?? kToolbarHeight,
//     );
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => Size.fromHeight(myToolbarHeight ?? kToolbarHeight + 20);
// }
//
// class WebAppBar extends StatelessWidget with PreferredSizeWidget {
//   const WebAppBar({
//     Key? key,
//     this.title,
//     this.actions,
//     this.centerTitle,
//     this.onTapBack,
//     this.leading,
//     this.showLeading,
//   }) : super(key: key);
//   final String? title;
//   final List<Widget>? actions;
//   final bool? centerTitle;
//   final Widget? leading;
//   final Function()? onTapBack;
//   final bool? showLeading;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: showLeading ?? true
//           ? GestureDetector(
//               onTap: onTapBack ??
//                   () {
//                     Navigator.pop(context);
//                   },
//               child: leading ??
//                   const Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Icon(
//                       Icons.arrow_back,
//                       size: 30,
//                       color: Colors.black,
//                     ),
//                   ))
//           : const SizedBox(),
//       elevation: 0,
//       title: Text(
//         title ?? '',
//         style: const TextStyle(
//           fontSize: 24,
//           color: Colors.black,
//         ),
//       ),
//       centerTitle: centerTitle ?? true,
//       actions: actions,
//       backgroundColor: Colors.transparent,
//     );
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
// }
