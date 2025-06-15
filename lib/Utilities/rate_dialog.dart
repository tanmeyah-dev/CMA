// // ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
//
// import 'package:Tanmeyah/Utilities/helper.dart';
// import 'package:flutter/material.dart';
// import 'package:rate_my_app/rate_my_app.dart';
// import '../Shared/constants.dart';
//
// class RateDialog{
//   RateMyApp? rateMyApp;
//
//   Future<void> rate(BuildContext context) async {
//     rateMyApp = RateMyApp(
//       preferencesPrefix: 'rateMyApp_',
//       googlePlayIdentifier: AppConstants.GOOGLE_ID,
//       appStoreIdentifier:  AppConstants.APPLE_ID,
//     );
//     await rateMyApp?.init();
//     rateMyApp?.showRateDialog(context,title: "rate_App".tr,message: "rate_message".tr);
//   }
//
// }