// // ignore_for_file: depend_on_referenced_packages
//
// import 'package:Tanmeyah/Theme/app_assets.dart';
// import 'package:Tanmeyah/Utilities/helper.dart';
// import 'package:Tanmeyah/Widgets/base_appbar.dart';
// import 'package:Tanmeyah/Widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../Theme/themeclass.dart';
//
// class EmptyServicesScreen extends StatelessWidget {
//   static const routeName = "/emptyServicesScreen";
//   const EmptyServicesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BaseAppBar.main(title: "services".tr,centerTitle: false,),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           color: ThemeClass.whiteColor,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(AppAssets.IMG_OFFER,width: 335.w,height: 255.h,),
//             SizedBox(height: 100.h,),
//             AppTextRegular(title: "otp_des".tr),
//           ],
//         ),
//       ),
//     );
//   }
// }
