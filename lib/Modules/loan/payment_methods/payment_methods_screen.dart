import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/custom_button_widget.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/base_appbar.dart';

class PaymentMethodsScreen extends StatelessWidget {
  String amount;
  static const String routeName = "/paymentMethodScreen";

  PaymentMethodsScreen({Key? key,required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "pay".tr,
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: 328.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.IMG_AMOUNT_BACKGROUND),
                            fit: BoxFit.fill)),
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      children: [
                        AppTextRegular(
                          title: "total_due".tr,
                          fontSize: 14.sp,
                          color: ThemeClass.fontColor,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        AppTextBold(
                          title: amount,
                          fontSize: 36.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: AppTextRegular(
                        title: "payment_way".tr,
                        color: ThemeClass.fontColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(height: 16.h,),
                  paymentItem(title: "fawry".tr,imagePath:AppAssets.IMG_PAYMENT1),
                  SizedBox(height: 8.h,),
                  paymentItem(title: "damen".tr,imagePath:AppAssets.IMG_PAYMENT2),
                  SizedBox(height: 8.h,),
                  paymentItem(title: "masry".tr,imagePath:AppAssets.IMG_PAYMENT3),
                  SizedBox(height: 8.h,),
                  paymentItem(title: "opay".tr,imagePath:AppAssets.IMG_PAYMENT4),
                  SizedBox(height: 8.h,),
                ],
              ),
            ),
            Align(alignment: Alignment.bottomCenter,child: CustomButton(
              width: 216.w,
              title: "back".tr,onTap: (){
              Navigator.pop(context);
            },),
            )
          ],
        ),
      ),
    );
  }

  paymentItem({required String title, required String imagePath}) {
    return Container(
      decoration: BoxDecoration(
          color: ThemeClass.termsBackground,
          borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextRegular(
            title: title,
            color: ThemeClass.secondaryColor,
          ),
          Image.asset(
            imagePath,
            width: 80.w,
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
