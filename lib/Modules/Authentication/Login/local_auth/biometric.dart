// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../Theme/themeclass.dart';
// import '../login_controller.dart';
// import 'local_auth_api.dart';
// import 'local_auth_screen.dart';
//
// class BiometricWidget extends StatefulWidget {
//   LoginController con;
//    BiometricWidget({required this.con, Key? key}) : super(key: key);
//
//   @override
//   State<BiometricWidget> createState() => _BiometricWidgetState();
// }
//
// class _BiometricWidgetState extends State<BiometricWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return FadeIn(
//         delay: 2,
//         from: SlideFrom.BOTTOM,
//         child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 80.w),
//             child: Row(
//                 mainAxisAlignment: (widget.con.hasFaceId && widget.con.hasFingerPrint)
//                     ? MainAxisAlignment.spaceBetween
//                     : MainAxisAlignment.center,
//                 children: [
//                   widget.con.hasFaceId
//                       ? GestureDetector(
//                       onTap: () async {
//                         bool result = await widget.con.getBiometricsData();
//                         if(!result) {
//                           Navigator.pushNamed(context, LocalAuthScreen.routeName);
//                         } else {
//                           final isAuthenticated =
//                           await LocalAuthApi.authenticate();
//                           if (isAuthenticated) {
//                             setState(() {
//                               widget.con.phoneController.text = widget.con.encryptedPhone!;
//                               widget.con.passwordController.text = widget.con.encryptedPassword!;
//                             });
//                             widget.con.logIn(context);
//                           }
//                         }
//
//                       },
//                       child: Icon(Icons.tag_faces,
//                           color: ThemeClass.primaryColor))
//                       : Container(),
//                   widget.con.hasFingerPrint
//                       ? GestureDetector(
//                       onTap: () async {
//                         bool result = await widget.con.getBiometricsData();
//                         if(!result) {
//                           Navigator.pushNamed(context, LocalAuthScreen.routeName);
//                         } else {
//                           final isAuthenticated =
//                           await LocalAuthApi.authenticate();
//                           if (isAuthenticated) {
//                             setState(() {
//                               widget.con.phoneController.text = widget.con.encryptedPhone!;
//                               widget.con.passwordController.text = widget.con.encryptedPassword!;
//                             });
//                             widget.con.logIn(context);
//                           }
//                         }
//
//                       },
//                       child: Icon(Icons.fingerprint,
//                           color: ThemeClass.primaryColor))
//                       : Container()
//                 ])));
//   }
// }
