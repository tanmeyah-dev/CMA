// // ignore_for_file: depend_on_referenced_packages
//
// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../Cache/app_languages.dart';
// import '../Theme/themeclass.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double height;
//   final Function()? onTapMenu;
//   final Function()? onTapFilter;
//   final Function()? onTapNotification;
//   final Function()? onTapCart;
//   final Function()? onTapSocialSharing;
//   final Function()? onTapFavoried;
//   final Function()? onTapPreviousOrder;
//   final Function()? onTapDelete;
//   final bool onlyBackWithIcon;
//   final bool mainAppBar;
//   final bool classicAppbar;
//   final bool titleAppBar;
//   final String? title;
//   final String? cartCount;
//   final String? orderCount;
//   final String? notificationCount;
//   final String? subTitle;
//
//   const CustomAppBar(
//       {Key? key,
//         this.height = kToolbarHeight,
//         this.onTapMenu,
//         this.onTapFilter,
//         this.onTapCart,
//         this.onTapPreviousOrder,
//         this.onTapDelete,
//         this.onTapSocialSharing,
//         this.onTapFavoried,
//         this.orderCount,
//         this.onTapNotification,
//         this.onlyBackWithIcon = false,
//         this.mainAppBar = false,
//         this.titleAppBar = false,
//         this.classicAppbar = false,
//         this.title,
//         this.notificationCount,
//         this.subTitle,
//         this.cartCount})
//       : super(key: key);
//
//   factory CustomAppBar.mainAppBar(
//       {Key? key,
//         required String title,
//         required String orderCount,
//         required String notificationCount,
//         required Function() onTapPreviousOrder,
//         required Function() onTapNotification,
//         required Function() onTapFilter}) =>
//       CustomAppBar(
//         key: key,
//         title: title,
//         mainAppBar: true,
//         notificationCount: notificationCount,
//         onTapPreviousOrder: onTapPreviousOrder,
//         onTapNotification: onTapNotification,
//         onTapFilter: onTapFilter,
//         orderCount: orderCount,
//       );
//
//   factory CustomAppBar.onlyBackWithIcon(
//       {Key? key,
//         String? title,
//         required String cartCount,
//         required Function() onTapCart,
//         required Function() onTapSocialSharing,
//         required Function() onTapFavoried}) =>
//       CustomAppBar(
//         key: key,
//         cartCount: cartCount,
//         onTapCart: onTapCart,
//         onTapSocialSharing: onTapSocialSharing,
//         onTapFavoried: onTapFavoried,
//         onlyBackWithIcon: true,
//         title: title,
//       );
//
//   factory CustomAppBar.classicAppBar({
//     Key? key,
//     String? title,
//     String? subTitle,
//     String? cartCount,
//     Function()? onTapFilter,
//     Function()? onTapCart,
//     Function()? onTapDelete,
//     Function()? onTapNotification,
//   }) =>
//       CustomAppBar(
//         key: key,
//         onTapFilter: onTapFilter,
//         onTapNotification: onTapNotification,
//         classicAppbar: true,
//         title: title,
//         cartCount: cartCount,
//         onTapCart: onTapCart,
//         onTapDelete: onTapDelete,
//         subTitle: subTitle,
//       );
//
//   factory CustomAppBar.titleAppBar({
//     Key? key,
//     String? title,
//   }) =>
//       CustomAppBar(
//         key: key,
//         titleAppBar: true,
//         title: title,
//       );
//
//   @override
//   Size get preferredSize => Size.fromHeight(subTitle != null
//       ? height + 20.h
//       : mainAppBar || titleAppBar
//       ? height + 42.h
//       : height);
//
//   @override
//   Widget build(BuildContext context) {
//     if (onlyBackWithIcon) return onlyBackAppBar(context);
//     if (classicAppbar) return classicAppBar(context);
//     if (mainAppBar) return homeAppBar(context);
//     if (titleAppBar) return appBarWithTitle(context);
//     return const SizedBox();
//   }
//
//   Widget homeAppBar(context) {
//     return Padding(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       child: Container(
//         height: preferredSize.height,
//         color: ThemeClass.backgroundAppBar,
//         child: Column(
//           children: [
//             Image.asset('assets/images/AppBar/Group 20330.png',
//                 height: 30.h, width: 64.w),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // SizedBox(
//                 //   width: 25.w,
//                 // ),
//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   children: [
//                 //     Text(
//                 //       'Hi'.tr,
//                 //       style: TextStyle(
//                 //           fontSize: 25.sp, fontWeight: FontWeight.w500),
//                 //     ),
//                 //     Text(
//                 //       title ?? '',
//                 //       style: TextStyle(
//                 //           fontSize: 25.sp,
//                 //           fontWeight: FontWeight.w500,
//                 //           height: 1.h),
//                 //     )
//                 //   ],
//                 // ),
//                 // Image.asset('assets/images/AppBar/Highlight_05.png',
//                 //     height: 17.h, width: 17.w),
//                 const Spacer(),
//                 GestureDetector(
//                   onTap: onTapPreviousOrder,
//                   child: Badge(
//                     elevation: 0,
//                     position: BadgePosition.topStart(),
//                     padding: EdgeInsets.all(3.w),
//                     badgeContent: Text(
//                       orderCount ?? '0',
//                       style: TextStyle(
//                           color: ThemeClass.whiteColor, fontSize: 10.sp),
//                     ),
//                     child:
//                     Image.asset('assets/images/AppBar/previous order.png'),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 16.w,
//                 ),
//                 GestureDetector(
//                     onTap: onTapFilter,
//                     child: Image.asset('assets/images/AppBar/Filter.png')),
//                 SizedBox(
//                   width: 16.w,
//                 ),
//                 GestureDetector(
//                   onTap: onTapNotification,
//                   child: Badge(
//                     elevation: 0,
//                     position: BadgePosition.topStart(),
//                     padding: EdgeInsets.all(3.w),
//                     badgeContent: Text(
//                       notificationCount ?? '0',
//                       style: TextStyle(
//                           color: ThemeClass.whiteColor, fontSize: 10.sp),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         top: 8.w,
//                         bottom: 8.w,
//                       ),
//                       child:
//                       Image.asset('assets/images/AppBar/Notification.png'),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 25.w,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget onlyBackAppBar(context) {
//     final appLan = Provider.of<AppLanguage>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       child: Container(
//         height: preferredSize.height,
//         color: ThemeClass.backgroundAppBar,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 25.w,
//             ),
//             GestureDetector(
//               onTap: () => Navigator.of(context).pop(),
//               child: appLan.appLocal.languageCode.toString() != 'en'
//                   ?  Icon(Icons.arrow_forward_ios,color : ThemeClass.primaryColor)
//                   : Icon(Icons.arrow_back_ios,color : ThemeClass.primaryColor),
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: onTapCart,
//               child: Badge(
//                 elevation: 0,
//                 position: BadgePosition.topStart(),
//                 padding: EdgeInsets.all(2.w),
//                 badgeContent: Text(
//                   cartCount ?? '',
//                   style:
//                   TextStyle(color: ThemeClass.whiteColor, fontSize: 10.sp),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     top: 8.w,
//                     right: 8.w,
//                     bottom: 8.w,
//                   ),
//                   child: Image.asset('assets/images/AppBar/cart.png'),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 16.w,
//             ),
//             GestureDetector(
//                 onTap: onTapFavoried,
//                 child: Image.asset('assets/images/AppBar/Favoried.png')),
//             SizedBox(
//               width: 16.w,
//             ),
//             GestureDetector(
//                 onTap: onTapSocialSharing,
//                 child: Image.asset('assets/images/AppBar/Social Sharing.png')),
//             SizedBox(
//               width: 25.w,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget classicAppBar(context) {
//     final appLan = Provider.of<AppLanguage>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       child: Container(
//         height: preferredSize.height,
//         color: ThemeClass.backgroundAppBar,
//         padding: EdgeInsets.symmetric(horizontal: 25.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: appLan.appLocal.languageCode.toString() == 'en'
//                       ?  Icon(Icons.arrow_forward_ios,color : ThemeClass.primaryColor)
//                       : Icon(Icons.arrow_back_ios,color : ThemeClass.primaryColor),
//
//                 ),
//                 SizedBox(
//                   width: 17.w,
//                 ),
//                 Text(
//                   title ?? '',
//                   maxLines: 2,
//                   style: TextStyle(
//                     fontSize: 31.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const Spacer(),
//                 Visibility(
//                   visible: onTapFilter != null,
//                   child: GestureDetector(
//                     onTap: onTapFilter,
//                     child: Image.asset("assets/images/AppBar/Filter.png",
//                         fit: BoxFit.fill, width: 17.w),
//                   ),
//                 ),
//                 Visibility(
//                   visible: onTapNotification != null,
//                   child: SizedBox(
//                     width: 17.w,
//                   ),
//                 ),
//                 Visibility(
//                   visible: onTapNotification != null,
//                   child: GestureDetector(
//                     onTap: onTapNotification,
//                     child: Image.asset("assets/images/AppBar/Notification.png",
//                         fit: BoxFit.fill, width: 17.w),
//                   ),
//                 ),
//                 Visibility(
//                   visible: onTapCart != null,
//                   child: GestureDetector(
//                     onTap: onTapCart,
//                     child: Badge(
//                       elevation: 0,
//                       position: BadgePosition.topStart(),
//                       padding: EdgeInsets.all(2.w),
//                       badgeContent: Text(
//                         cartCount ?? '',
//                         style: TextStyle(
//                             color: ThemeClass.whiteColor, fontSize: 10.sp),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           top: 8.w,
//                           right: 8.w,
//                           bottom: 8.w,
//                         ),
//                         child: Image.asset('assets/images/AppBar/cart.png'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: onTapDelete != null,
//                   child: GestureDetector(
//                     onTap: onTapDelete,
//                     child: Image.asset("assets/images/AppBar/delete.png",
//                         fit: BoxFit.fill, width: 17.w),
//                   ),
//                 ),
//               ],
//             ),
//             if (subTitle != null)
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30.0.w),
//                 child: Text(
//                   subTitle ?? '',
//                   style: TextStyle(
//                     height: 1.h,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget appBarWithTitle(context) {
//     final appLan = Provider.of<AppLanguage>(context);
//
//     return Padding(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       child: Container(
//           height: preferredSize.height,
//           color: ThemeClass.backgroundAppBar,
//           padding: EdgeInsets.symmetric(horizontal: 25.w),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.h),
//                 child: GestureDetector(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: appLan.appLocal.languageCode.toString() == 'en'
//                       ?  Icon(Icons.arrow_forward_ios,color : ThemeClass.primaryColor)
//                       : Icon(Icons.arrow_back_ios,color : ThemeClass.primaryColor),
//
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   title ?? '',
//                   maxLines: 3,
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     color: ThemeClass.primaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
