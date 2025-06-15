// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../Modules/Authentication/Register/register_controller.dart';
// import 'custom_textfield_widget.dart';
//
//
// class DateWidget extends StatelessWidget {
//   const DateWidget({
//     Key? key,
//     required this.con,
//     required this.title,
//     required this.hint,
//   }) : super(key: key);
//
//   final RegisterController con;
//   final String title, hint;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         await con.iosDatePicker(context: context, dateOrTime: title);
//       },
//       child: CustomTextFieldWidget(
//         hint: hint,
//         controller: con.dateController,
//         enable: false,
//         suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,),
//         style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xffA5A5A5)),
//       ),
//     );
//   }
// }
