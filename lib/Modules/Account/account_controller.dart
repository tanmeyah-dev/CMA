// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Network/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:geolocator/geolocator.dart';

import '../../Models/government_model.dart';
import '../../Models/user_model.dart';
import '../../Shared/shared_prefirences.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_analytics/firebase_analytics.dart';



class AccountController extends ControllerMVC {
  // singleton
  factory AccountController() {
    _this ??= AccountController._();
    return _this!;
  }

  static AccountController? _this;

  AccountController._();

  bool loading = false, autoValidate = false , guestMood = false;

  Position? currentPosition;

  UserModel? userModel;

  String? city;


  @override
  void initState() {
    if(SharedPref.getUserObg() != null) {
      getUserData();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }




  getUserData() async {

    loading = true;
    setState(() { });
    userModel = SharedPref.getUserObg();

    List<GovernmentModel> governmentsIds = [
      GovernmentModel(id: "1", title: 'القاهرة'),
      GovernmentModel(id: "2", title: 'الفيوم'),
      GovernmentModel(id: "61", title: 'كفر الشيخ'),
      GovernmentModel(id: "62", title: 'الاسكندرية'),
      GovernmentModel(id: "63", title: 'بني سويف'),
      GovernmentModel(id: "64", title: 'الغربية'),
      GovernmentModel(id: "65", title: 'الدقهلية'),
      GovernmentModel(id: "66", title: 'الشرقية'),
      GovernmentModel(id: "67", title: 'البحيرة'),
      GovernmentModel(id: "68", title: 'الوادي الجديد'),
      GovernmentModel(id: "69", title: 'البحر الاحمر'),
      GovernmentModel(id: "70", title: 'سوهاج'),
      GovernmentModel(id: "71", title: 'اسوان'),
      GovernmentModel(id: "72", title: 'اسيوط'),
      GovernmentModel(id: "73", title: 'قنا'),
      GovernmentModel(id: "74", title: 'المنيا'),
      GovernmentModel(id: "75", title: 'الجيزه'),
      GovernmentModel(id: "76", title: 'مرسي مطروح'),
      GovernmentModel(id: "79", title: 'دمياط'),
      GovernmentModel(id: "81", title: 'القليوبيه'),
      GovernmentModel(id: "101", title: 'المنوفيه'),
      GovernmentModel(id: "121", title: 'السويس'),
      GovernmentModel(id: "141", title: 'بورسعيد'),
      GovernmentModel(id: "161", title: 'الاسماعليه'),
      GovernmentModel(id: "162", title: 'الاقصر'),
    ];


    GovernmentModel  title = governmentsIds.firstWhere((e) => e.id == (userModel?.governmentId??""));
    city = title.title;
    loading = false;
    setState(() { });
  }

  Future logout(BuildContext context,String phone,String nationalId) async {
    loading = true;
    setState(() { });
   bool? result =  await UserApi.deactivateUser(context, phone: phone, nationalId: nationalId);
    loading = false;
    setState(() {});
    if(result == true){
      final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      analytics.logEvent(
          name: 'user_deactivate_account',
          parameters: <String,dynamic>{
            "title" :"user_deactivate_account"
          }
      );
      await SharedPref.logOut();
      Modular.to.pushNamedAndRemoveUntil(
          "/loginScreen", (Route<dynamic> route) => false,
          arguments: "");
    }
  }

}
