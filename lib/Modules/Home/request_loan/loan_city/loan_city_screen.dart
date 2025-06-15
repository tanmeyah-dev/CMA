// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:Tanmeyah/Modules/Home/request_loan/loan_checkout/loan_checkout_screen.dart';
import 'package:Tanmeyah/Utilities/general_toast.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Models/government_model.dart';
import '../../../../Models/loan_checkout_model.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/drop_down_list.dart';
import 'loan_city_controller.dart';
import 'package:iconsax/iconsax.dart';

class LoanCityScreen extends StatefulWidget {
  static const String routeName = "/loanCityScreen";

  LoanCheckoutModel loanCheckoutModel;

  LoanCityScreen({required this.loanCheckoutModel,Key? key}) : super(key: key);

  @override
  _LoanCityScreenState createState() => _LoanCityScreenState();
}

class _LoanCityScreenState extends StateMVC<LoanCityScreen>
    with WidgetsBindingObserver {
  _LoanCityScreenState() : super(LoanCityController()) {
    con = LoanCityController();
  }


  late LoanCityController con;

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      appBar: BaseAppBar.main(
        title: "ask_loan".tr,
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              alignment: Alignment.topRight,
              color: ThemeClass.whiteColor,
              child: SingleChildScrollView(
                child:  Form(
                  key: con.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h,),
                      AppTextRegular(title: "nearest_branch".tr,fontSize: 20.sp,),
                      SizedBox(height: 4.h,),
                      Divider(),
                      AppTextRegular(title: "choose_gov".tr,fontSize: 16.sp,),
                      SizedBox(height: 8.h,),
                      CustomDropDownWidget<String>(
                        hint: "choose_gov".tr,
                        selected: con.governmentsIds.any((item) => item.id == con.selectedGovernmentId)
                            ? con.selectedGovernmentId // ✅ Assign only if it exists
                            : null, // ✅ Prevents error if it doesn’t exist
                        onChange: (String? selectedId) {
                          if (selectedId != null) {
                            con.selectedGovernmentId = selectedId;
                            final selectedItem = con.governmentsIds.firstWhere(
                                  (item) => item.id == selectedId,
                                orElse: () => GovernmentModel(id: '', title: ''),
                            );
                            if (selectedItem != null) {
                              con.governmentTitle = selectedItem.title; // ✅ Get the name (title)
                              con.getCityByGovernorat(governerateId: selectedId);
                            }
                            setState(() {});
                          }
                        },
                        borderColor: Colors.grey,
                        items: con.governmentsIds.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.id,
                            child: Text(item.title,
                                style: TextStyle(fontSize: 16.sp, height: -0.2)),
                          );
                        }).toList(),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Icon(
                            Iconsax.arrow_down5,
                            color: ThemeClass.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      AppTextRegular(title: "choose_branch".tr,fontSize: 16.sp,),
                      SizedBox(height: 8.h,),
                      con.selectedGovernmentId != null ?
                      CustomDropDownWidget<String>(
                        hint: "choose_branch".tr,
                        selected: con.branchList?.any((item) => item.id == con.selectedCityId) ?? false
                            ? con.selectedCityId // ✅ Assign only if it exists
                            : null, // ✅ Prevents error if it doesn’t exist
                        onChange: (String? selectedId) {
                          if (selectedId != null) {
                            con.selectedCityId = selectedId;
                            // Ensure `branches` is not null before calling `firstWhere`
                            final selectedItem = con.cityResponse?.branches != null
                                ? con.cityResponse!.branches!.firstWhere(
                                  (item) => item.id == selectedId,
                              orElse: () => BranchModel(id: '', nameAr: ''),
                            )
                                : null;

                            // Ensure `selectedItem` is not null before accessing properties
                            if (selectedItem != null && selectedItem.id! != null) {
                              con.cityTitle = selectedItem.nameAr; // ✅ Get the name/title safely
                            } else {
                              con.cityTitle = "Unknown"; // Provide a default fallback
                            }

                            setState(() {});
                          }
                        },
                        borderColor: Colors.grey,
                        items:  con.branchList?.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.nameAr??"",
                                style: TextStyle(fontSize: 16.sp, height: -0.2)),
                          );
                        }).toList() ?? [],
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Icon(
                            Iconsax.arrow_down5,
                            color: ThemeClass.secondaryColor,
                          ),
                        ),
                      ) : GestureDetector(
                        onTap: (){
                          ToastHelper.showError(context,message: "برجاء اختيار المحافظه اولا");
                        },
                        child: Container(
                          width: 385.w,
                          padding: EdgeInsets.only(left: 20.w,right: 10.h,top: 12.h,bottom: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.w),
                            border: Border.all(color: ThemeClass.hintColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextHint(title: "choose_branch".tr),
                              Icon(
                                Iconsax.arrow_down5,
                                color: ThemeClass.secondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 430.h,),
                      Center(child: CustomButton(title: "next".tr, onTap: (){
                        if(con.selectedGovernmentId != null && con.selectedCityId != null){
                          widget.loanCheckoutModel.govId = con.selectedGovernmentId.toString();
                          widget.loanCheckoutModel.branchId = con.selectedCityId.toString();
                          widget.loanCheckoutModel.govTitle = con.governmentTitle;
                          widget.loanCheckoutModel.branchTitle = con.cityTitle;
                          Navigator.pushNamed(context, LoanCheckoutScreen.routeName,arguments: widget.loanCheckoutModel);
                        }else {
                          ToastHelper.showError(context,message: "برجاء اختيار الفرع");
                        }
                      },width: 385.w),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
