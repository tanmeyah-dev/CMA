import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../Theme/themeclass.dart';
import '../Utilities/helper.dart';
import 'custom_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';


class ReceiptAlert{
  static Future getReceipt(
      {required BuildContext context, required Function() onTap,required String phoneNumber, required double amount,required double fees}) async {
    DateTime date = DateTime.now();
    String dateForm = DateFormat('dd MMMM yyyy، hh:mm a', 'ar').format(date);

    Helper.showDialogWidget(
        onTap: onTap,
        context: context,
        child: SizedBox(
          height: 420.h,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: ThemeClass.hintColor,
                      borderRadius: BorderRadius.circular(8.w)
                    ),
                    child: InkWell(
                        onTap: () async {
                          Modular.to.pop();
                        },
                        child: const Icon(Icons.close,size: 20,)),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 6.h,),
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeClass.primaryColor.withOpacity(0.1)
                ),
                child: Icon(Iconsax.receipt_2_15,color: ThemeClass.primaryColor,size: 32.sp,),
              ),
              SizedBox(height: 16.h,),
              AppTextBold(title: "ملخص الدفع",color: ThemeClass.blackColor,),
              SizedBox(height: 12.h,),
              Container(width: 100.w,height: 2.h,color: ThemeClass.borderColor,),
              SizedBox(height: 30.h,),
              Column(
                children: [
                  SizedBox(height: 12.h,),
                  info(title: "رقم الموبايل", data: phoneNumber),
                  info(title: "التاريخ والوقت", data: "${dateForm}"),
                  info(title: "قيمة الفاتورة", data: "${amount} ج م "),
                  info(title: "مصاريف الخدمة", data: "${fees} ج م "),
                  SizedBox(height: 20.h,),
                  info(title: "الاجمالي", data: "${amount+fees} ج م "),
                  SizedBox(height: 20.h,),
                ],
              ),
              Spacer(),
              CustomButton(
                title: 'دفع',
                height: 40.h,
                fontSize: 14.sp,
                onTap: () => onTap(),
              ),
            ],
          ),
        ));
  }

}


Widget info({required String title, required String data}){
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextRegular(title: title,color: ThemeClass.borderColor,),
          AppTextRegular(title: data)
        ],
      ),
      SizedBox(height: 8.h,),
    ],
  );
}