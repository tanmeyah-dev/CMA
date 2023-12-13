// import 'package:Tanmeyah/Utilities/helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../Shared/shared_prefirences.dart';
//
// class ConnectivityChecker extends StatefulWidget {
//   final Widget child;
//   final Function()? onLoading;
//   const ConnectivityChecker({Key? key, required this.child, this.onLoading})
//       : super(key: key);
//
//   @override
//   State<ConnectivityChecker> createState() => _ConnectivityCheckerState();
// }
//
// class _ConnectivityCheckerState extends State<ConnectivityChecker> {
//   @override
//   void initState() {
//     // ConnectivityHelper().addListener(widget.onLoading);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<bool>(
//         // stream: ConnectivityHelper().connectionChange,
//         initialData: true,
//         builder: (context, snapshot) {
//           return !snapshot.data!
//               ? Container(
//                   width: double.infinity,
//                   // height: 600.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10.w),
//                   ),
//                   alignment: Alignment.center,
//                   child: SafeArea(
//                     child: Directionality(
//                       textDirection: SharedPref.getCurrentLang() == 'ar'
//                           ? TextDirection.rtl
//                           : TextDirection.ltr,
//                       child: Scaffold(
//                         body: Center(
//                           child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   height: 32.h,
//                                 ),
//                                 Text(
//                                   'Connection failed'.tr.toUpperCase(),
//                                 ),
//                                 SizedBox(
//                                   height: 32.h,
//                                 ),
//                                 SizedBox(
//                                   height: 32.h,
//                                 ),
//                                 Text(
//                                   'No Internet Connection'.tr.toUpperCase(),
//                                   ),
//                                 SizedBox(
//                                   height: 20.h,
//                                 ),
//                                 Text(
//                                   'check your internet'.tr,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontFamily:
//                                         SharedPref.getCurrentLang() == 'ar'
//                                             ? "Almarai"
//                                             : "Montserrat",
//                                   ),
//                                 ),
//                                 // Spacer(),
//                                 SizedBox(height: 16.h),
//                                 InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       print('try again connection');
//                                     });
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsetsDirectional.fromSTEB(
//                                         40.w, 0, 40.w, 0),
//                                     alignment: AlignmentDirectional.center,
//                                     height: 55.h,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.amber,
//                                     ),
//                                     child: Text(
//                                       'try again'.tr.toUpperCase(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 22.sp,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily:
//                                             SharedPref.getCurrentLang() == 'ar'
//                                                 ? "Almarai"
//                                                 : "Montserrat",
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : widget.child;
//         });
//   }
// }
