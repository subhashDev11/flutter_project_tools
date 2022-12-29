//
// import 'package:adopt_a_backpacker/app_export.dart';
// import 'package:adopt_a_backpacker/RouteName/app_RouteName.gr.dart';
// import 'package:adopt_a_backpacker/widgets/shared/dialog/app_dialog.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mapbox_search/mapbox_search.dart';
// import '../common_screens/mapbox_search_location_screen.dart';
// import '../widgets/general_dialog_view.dart';
// import 'logger_utils.dart';
//
// class LocationUtility {
//
//   static Future<MapBoxPlace?> searchLocation({String? searchHint,required BuildContext currentContext}) async{
//     MapBoxPlace? mapBoxPlace;
//     await Navigator.push(
//       currentContext,
//       MaterialPageRoute(
//         builder: (context) => MapBoxAutoCompleteScreen(
//           apiKey: mapBoxId,
//           hint: searchHint ?? "Select starting point",
//           onSelect: (place) {
//             mapBoxPlace = place;
//           },
//           limit: 10,
//         ),
//       ),
//     );
//     return mapBoxPlace;
//   }
//
//  static Future<Position?> fetchLocationData() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       AppLogger.e('Location service not enabled!');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//        await showPermissionAccessDialog();
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       await showPermissionAccessDialog();
//     }
//     final position = await Geolocator.getCurrentPosition();
//     AppLogger.i('Current Location Position - ${position.toJson()}');
//     return position;
//   }
//
//  static Future<Address?> getAddressFromPosition(double? lat, double? long) async {
//     if (lat != null && long != null) {
//       try{
//         final coordinates = Coordinates(lat, long);
//         final addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//         AppLogger.i('Fetch Address - ${addresses.first.toMap()}');
//         return addresses.first;
//       }catch(e){
//         AppLogger.e('Failed to get address from position - $e');
//         return null;
//       }
//     } else {
//       try{
//         bool serviceEnabled;
//         LocationPermission permission;
//         serviceEnabled = await Geolocator.isLocationServiceEnabled();
//         if (!serviceEnabled) {
//           AppLogger.e('Location service not enabled!');
//         }
//
//         permission = await Geolocator.checkPermission();
//         if (permission == LocationPermission.denied) {
//           permission = await Geolocator.requestPermission();
//           if (permission == LocationPermission.denied) {
//             await Geolocator.openAppSettings();
//           }
//         }
//
//         if (permission == LocationPermission.deniedForever) {
//           await Geolocator.openAppSettings();
//         }
//         final position = await Geolocator.getCurrentPosition();
//         final coordinates = Coordinates(position.latitude, position.longitude);
//         final addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//         AppLogger.i('Fetch Address - ${addresses.first.toMap()}');
//         return addresses.first;
//       }catch(e){
//         AppLogger.e('Failed to get address from position - $e');
//         return null;
//       }
//     }
//   }
//
//   static Future<void> showPermissionAccessDialog() async{
//     final context = getIt<AppRouter>().navigatorKey.currentState?.context;
//     if(context!=null) {
//       await appDialog(context, GeneralDialogView(
//         title: FlutterI18n.translate(context, 'app_name'),
//         subTitle: FlutterI18n.translate(context, 'location_denied_msg'),
//         positiveAction: () async {
//           if(context.router.canNavigateBack){
//              context.router.pop();
//           }else {
//             Navigator.of(context).pop();
//           }
//           await Geolocator.requestPermission();
//         },
//       ));
//   }
//   }
//
// }
