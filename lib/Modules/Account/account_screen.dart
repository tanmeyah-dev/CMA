// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, deprecated_member_use
import 'package:Tanmeyah/Models/user_model.dart';
import 'package:Tanmeyah/Modules/Account/account_controller.dart';
import 'package:Tanmeyah/Modules/Account/widget/user_data.dart';
import 'package:Tanmeyah/Modules/Account/widget/user_data_withedit.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Models/government_model.dart';
import '../../Theme/app_assets.dart';
import '../../Theme/themeclass.dart';
import '../../Utilities/loading_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../Widgets/animated_alert.dart';
import '../../Widgets/custom_button_widget.dart';
import '../../Widgets/custom_text.dart';
import '../Authentication/Login/login_screen.dart';
import '../More/main_more/widget/logout_alert.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class AccountScreen extends StatefulWidget {
  static const String routeName = "/accountScreen";

  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends StateMVC<AccountScreen> {
  _AccountScreenState() : super(AccountController()) {
    con = AccountController();
  }

  late AccountController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(
            title: "account".tr),
        body: SafeArea(
            child: LoadingScreen(
              loading: con.loading,
              child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: SharedPref.getUserObg() != null
                      ? Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ThemeClass.whiteColor),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(children: [
                            SizedBox(height: 10.h),
                            UserDataWidget(
                                    title: "full_name".tr,
                                    data: con.userModel?.fullName ?? ""),
                            UserDataWidget(
                                    title: "id_num".tr,
                                    data: con.userModel?.nationalId ?? ""),
                          UserDataWidget(
                                    title: "birthday".tr,
                                    data: con.userModel?.birthDate
                                        .substring(0, 11) ??
                                        ""),

                            UserDataWidget(
                                    title: "phone_number".tr,
                                    data:
                                    con.userModel?.mobileNumber ?? ""),
                            con.userModel?.email != null ?
                            UserDataWithEdit(
                                  title: "email".tr,
                                  data: con.userModel?.email != null
                                      ? con.userModel!.email!
                                      : "example@example.com") : Container(),

                                UserDataWithEdit(
                                    title: "government".tr,
                                    data:  con.city != null ? con.city! : "القاهره"),
                             UserDataWithEdit(
                                    title: "password".tr,
                                    data: "*************"),
                            SizedBox(height: 16.h,),
                            !con.guestMood?
                            CustomButton(
                              width: 216,
                              title: "deactivate".tr,
                              backgroundColor: ThemeClass.whiteColor,
                              textColor: ThemeClass.primaryColor,
                              borderColor: ThemeClass.primaryColor,
                              onTap: () {
                                final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                                _analytics.logEvent(
                                    name: 'request_deactivate_account',
                                    parameters: <String,Object>{
                                      "title" :"request_deactivate_account"
                                    }
                                );
                                AnimatedAlertDialog(context,
                                    LogoutAlertWidget(message : "deactivate_message".tr ,onOkPressed: () {
                                      con.logout(context,con.userModel?.mobileNumber??"",con.userModel?.nationalId??"");
                                    }));
                              },

                            ) : Container(),
                            SizedBox(height: 20.h,),

                          ]),
                        ),
                      ))
                      : Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 10.h),
                      Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Image.asset(AppAssets.IMG_EMPTY_ACCOUNT,
                                width: double.infinity,
                                height: 357.h,
                                fit: BoxFit.fill),
                          ),
                        SizedBox(height: 16.h),
                        Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w),
                                child: AppTextBold(
                                    title: "guest_des".tr)),
                        SizedBox(
                          height: 100.h,
                        ),
                        CustomButton(
                                width: 216,
                                title: "login".tr,
                                onTap: () async {
                                  Navigator.of(context,
                                      rootNavigator: true)
                                      .push(MaterialPageRoute(
                                      builder: (context) =>
                                          LoginScreen(
                                            phoneNumber: "",
                                          ),
                                      maintainState:
                                      false)); // await con.register(context);
                                }),
                      ])),
            )));
  }
}
