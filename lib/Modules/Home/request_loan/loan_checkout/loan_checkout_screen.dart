// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Models/loan_checkout_model.dart';
import 'package:Tanmeyah/Modules/Home/request_loan/loan_checkout/loan_checkout_controller.dart';
import 'package:Tanmeyah/Shared/shard_obj.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Shared/shared_prefirences.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';


class LoanCheckoutScreen extends StatefulWidget {
  static const String routeName = "/loanCheckoutScreen";
  LoanCheckoutModel loanCheckoutModel;
  LoanCheckoutScreen({required this.loanCheckoutModel,Key? key}) : super(key: key);

  @override
  _LoanCheckoutScreenState createState() => _LoanCheckoutScreenState();
}

class _LoanCheckoutScreenState extends StateMVC<LoanCheckoutScreen>
    with WidgetsBindingObserver {
  _LoanCheckoutScreenState() : super(LoanCheckoutController()) {
    con = LoanCheckoutController();
  }


  late LoanCheckoutController con;

  @override
  void initState() {
    con.loanCheckoutModel =  widget.loanCheckoutModel;
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      loading: con.loading,
      child: Scaffold(
        backgroundColor: ThemeClass.whiteColor,
        appBar: BaseAppBar.main(
          title: "ask_loan".tr,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              color: ThemeClass.whiteColor,
              child:Column(
                children: [
                    Image.asset(AppAssets.IMG_CHECKOUT,width: 370.w,height: 320.h,),
                    SizedBox(height: 32.h,),
                    AppTextMedium(title: "order_details".tr,color: ThemeClass.profileContainer,),
                    SizedBox(height: 32.h,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ThemeClass.borderColor,
                        borderRadius: BorderRadius.circular(4.r)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextRegular(title: "id_number".tr,color: ThemeClass.whiteColor,),
                          AppTextRegular(title: "${SharedPref.getUserObg()?.nationalId}",color: ThemeClass.whiteColor,fontWeight: FontWeight.w500,)
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h,),
                    Divider(),
                    SizedBox(height: 16.h,),
                    info(title: "loan_amount_checkout".tr, data:  widget.loanCheckoutModel.amountTitle??"",),
                    SizedBox(height: 6.h,),
                    info(title: "government".tr, data: widget.loanCheckoutModel.govTitle??"",),
                    SizedBox(height: 6.h,),
                    info(title: "branch".tr, data: widget.loanCheckoutModel.branchTitle??""),
                    SizedBox(height: 16.h,),
                    Divider(),
                    SizedBox(height : 90.h),
                    CustomButton(title: "send".tr, onTap: (){
                      con.LoanCheckout(context: context);
                    },width: 385.w,backgroundColor: ThemeClass.profileContainer,borderColor: ThemeClass.profileContainer,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget info({required String title,required String data}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextRegular(title: title),
        AppTextRegular(title: data)
      ],
    );
  }
}
