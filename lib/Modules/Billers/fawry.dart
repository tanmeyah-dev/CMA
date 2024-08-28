// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:fawry_sdk/fawry_sdk.dart';
// import 'package:fawry_sdk/fawry_utils.dart';
// import 'package:fawry_sdk/model/bill_item.dart';
// import 'package:fawry_sdk/model/fawry_launch_model.dart';
// import 'package:fawry_sdk/model/launch_customer_model.dart';
// import 'package:fawry_sdk/model/launch_merchant_model.dart';
// import 'package:fawry_sdk/model/payment_methods.dart';
// import 'package:fawry_sdk/model/response.dart';
//
//
//
//
// class FawrySDKScreen extends StatefulWidget {
//   const FawrySDKScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FawrySDKScreen> createState() => _FawrySDKScreenState();
// }
//
// class _FawrySDKScreenState extends State<FawrySDKScreen> {
//   late StreamSubscription? _fawryCallbackResultStream;
//
//   @override
//   void initState() {
//     super.initState();
//     initSDKCallback();
//     startPayment();
//   }
//
//   @override
//   void dispose() {
//     _fawryCallbackResultStream?.cancel();
//     super.dispose();
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Fawry SDK Flutter example'),
//       ),
//       body: Container(),
//     );
//   }
// }