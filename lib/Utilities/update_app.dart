//
// import 'dart:io';
// import 'package:upgrader/upgrader.dart';
// import 'package:in_app_update/in_app_update.dart';
//
// class UpdateApp{
//
//   static Future<void> startFlexibleUpdate() async {
//     if(!Platform.isAndroid) return;
//     try{
//       final checker = await InAppUpdate.checkForUpdate();
//       if(checker.updateAvailability > 0){
//         await InAppUpdate.startFlexibleUpdate();
//         await InAppUpdate.completeFlexibleUpdate();
//       }
//     }catch(e){}
//   }
// }