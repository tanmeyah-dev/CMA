// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/general_toast.dart';
import '../../../../Utilities/loading_screen.dart';
import 'loan_request_amount_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:Tanmeyah/Modules/Main/main_screen.dart';
import 'package:tan_sdk/tan_sdk_entry.dart';

class LoanRequestAmountScreen extends StatefulWidget {
  static const String routeName = "/loanAmountScreen";

  const LoanRequestAmountScreen({super.key});

  @override
  _LoanAmountScreenState createState() => _LoanAmountScreenState();
}

class _LoanAmountScreenState extends StateMVC<LoanRequestAmountScreen>
    with WidgetsBindingObserver {
  _LoanAmountScreenState() : super(LoanRequestAmountController()) {
    con = LoanRequestAmountController();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if(state == AppLifecycleState.resumed)  {
  //     await con.getCurrentPosition(context);
  //     setState(() { });
  //   }
  // }

  // @override
  // void didUpdateWidget(covariant StatefulWidget oldWidget) {
  //   con.getCurrentPosition(context);
  //   super.didUpdateWidget(oldWidget);
  // }

  int? _selectedIndex;
  static const int _youthFinanceIndex = -1;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    analytics.logEvent(
        name: 'open_loan_amount_screen',
        parameters: <String, Object>{"title": "open_loan_amount_screen"});
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if(state == AppLifecycleState.resumed){
  //     print(">>>>>>>>>>>>>>>");
  //     con.checkLocation(context);
  //   }
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    con.checkLocation(context: context, isInitLocation: false);
  }

  late LoanRequestAmountController con;

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
              child: Form(
                key: con.formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                          Image.asset(
                            AppAssets.IMG_AMOUNT,
                            width: 366.w,
                            height: 320.h,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: AppTextMedium(
                              title: con.loanProductsResponse?.title ?? "",
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          (con.loanProductsResponse?.loanRequestProducts !=
                                      null &&
                                  con.loanProductsResponse!.loanRequestProducts!
                                      .isNotEmpty)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: con.loanProductsResponse!
                                      .loanRequestProducts!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (_selectedIndex == index) {
                                                  _selectedIndex = null;
                                                } else {
                                                  _selectedIndex = index;
                                                  con.selectedValue = con
                                                      .loanProductsResponse!
                                                      .loanRequestProducts![
                                                          index]
                                                      .id;
                                                  con.selectedTitle = con
                                                      .loanProductsResponse!
                                                      .loanRequestProducts![
                                                          index]
                                                      .name;
                                                }
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(8.r),
                                              padding: EdgeInsets.all(16.r),
                                              decoration: BoxDecoration(
                                                color: _selectedIndex == index
                                                    ? ThemeClass
                                                        .selectBackground
                                                    : ThemeClass.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 16.w),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(1.w),
                                                    width: 24.w,
                                                    height: 24.h,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: con.accept
                                                            ? ThemeClass
                                                                .profileContainer
                                                            : Colors
                                                                .grey, // border color
                                                        width: 2.w,
                                                      ),
                                                    ),
                                                    child:
                                                        _selectedIndex == index
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ThemeClass
                                                                      .profileContainer,
                                                                ),
                                                              )
                                                            : null,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  AppTextRegular(
                                                    title: con
                                                            .loanProductsResponse!
                                                            .loanRequestProducts![
                                                                index]
                                                            .name ??
                                                        "",
                                                    color: _selectedIndex ==
                                                            index
                                                        ? ThemeClass
                                                            .profileContainer
                                                        : ThemeClass.blackColor,
                                                    fontWeight:
                                                        _selectedIndex == index
                                                            ? FontWeight.w700
                                                            : FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                            ));
                                  },
                                )
                              : Container(),
                          SizedBox(
                            height: 16.h,
                          ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        children: [
                          _buildYouthFinanceOption(),
                          SizedBox(height: 16.h),
                          _selectedIndex != null
                              ? CustomButton(
                                  width: 385.w,
                                  title: "next".tr,
                                  onTap: () {
                                    if (_selectedIndex == _youthFinanceIndex) {
                                      _openYouthFinanceSdk();
                                      return;
                                    }
                                    print("SELECTED ${con.selectedValue}");
                                    con.proceedWithSelectedProduct(context);
                                  },
                                  color: ThemeClass.textFieldBackgroundColor,
                                  borderColor:
                                      ThemeClass.textFieldBackgroundColor,
                                  textColor: ThemeClass.whiteColor,
                                  backgroundColor: ThemeClass.primaryColor,
                                )
                              : CustomButton(
                                  width: 385.w,
                                  title: "next".tr,
                                  backgroundColor:
                                      ThemeClass.buttonNotActiveColor,
                                  borderColor:
                                      ThemeClass.buttonNotActiveColor,
                                  onTap: () {
                                    if (con.formKey.currentState!.validate()) {
                                      if (con.loanAmount.text.isNotEmpty &&
                                          con.loanAmount.text.length > 3) {
                                        if (con.currentPosition == null) {
                                          con.checkLocation(
                                              context: context,
                                              isInitLocation: true);
                                        } else {
                                          con.applyForLoan(context);
                                        }
                                      } else {
                                        ToastHelper.showError(context,
                                            message: "enter_amount".tr);
                                      }
                                    } else {
                                      setState(() {
                                        con.autoValidate = true;
                                      });
                                    }
                                  },
                                ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openYouthFinanceSdk() {
    final phoneNumber = SharedPref.getUserObg()?.mobileNumber;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TanSdkEntry(
          phoneNumber: phoneNumber,
          onCompleted: () {
            Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              MainScreen.routeName,
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
    );
  }

  Widget _buildYouthFinanceOption() {
    final bool isSelected = _selectedIndex == _youthFinanceIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = _youthFinanceIndex;
          con.selectedTitle = "youth_finance".tr;
          final youthProduct = con.loanProductsResponse?.loanRequestProducts
              ?.where((product) =>
                  product.name?.contains("شباب") == true ||
                  product.name?.toLowerCase().contains("youth") == true)
              .toList();
          con.selectedValue = youthProduct != null && youthProduct.isNotEmpty
              ? youthProduct.first.id
              : null;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ThemeClass.selectBackground
              : ThemeClass.containerBackground,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(1.w),
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ThemeClass.borderColor,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeClass.profileContainer,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 8.w),
            AppTextRegular(
              title: "youth_finance".tr,
              color: isSelected
                  ? ThemeClass.profileContainer
                  : ThemeClass.blackColor,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.  w400,
              fontSize: 16.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E8),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: ThemeClass.monthColor,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info,
                        size: 14.sp,
                        color: ThemeClass.monthColor,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          "complete_request_via_tanmeyah_app".tr,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: ThemeClass.monthColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
