import 'package:Tanmeyah/Modules/Home/main_home/home_controller.dart';
import 'package:Tanmeyah/Modules/More/main_services/main_services_screen.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../More/services_detail/services_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';


class ProductsWidget extends StatelessWidget {
  HomeController con;
  ProductsWidget({Key? key,required this.con}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeIn(
          delay: 1.5,
          from: SlideFrom.BOTTOM,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: AppTextRegular(
                      title: "services".tr,
                      fontSize: 20.sp,
                    )),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, MainServicesScreen.routeName);
                },
                child: Row(
                  children: [
                    AppTextMedium(title: "all_services_project".tr,color: ThemeClass.yellowColor,fontSize: 14.sp,fontWeight: FontWeight.w400,),
                    Icon(Iconsax.arrow_square_left5,color: ThemeClass.yellowColor,size: 16.sp,)
                  ],
                ),
              ),
              ],
            ),
          )
        ),
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: con.homeResponse?.products.length,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                  _analytics.logEvent(
                      name: 'request_service',
                      parameters: <String,dynamic>{
                        "title" :"request_service_with  ${con.homeResponse?.products[index].nameAr}"
                      }
                  );
                  Navigator.pushNamed(context,
                      ServicesDetailScreen.routeName,
                      arguments: con
                          .homeResponse!.products[index]);
                },
                child: FadeIn(
                  delay: 2,
                  from: SlideFrom.BOTTOM,
                  child: Container(
                    width: 354.w,
                    padding: EdgeInsets.symmetric(
                        vertical: 22.h, horizontal: 30.w),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(20.w),
                      color: ThemeClass.greyBackgroundColor
                          .withOpacity(0.1),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(24.w),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(16.w),
                            child: con
                                .homeResponse!
                                .products[index]
                                .logo !=
                                null
                                ? Image.network(con
                                .homeResponse!
                                .products[index]
                                .logo ??
                                "",width: 40.w,height: 40.h,)
                                : Image.asset(
                              AppAssets
                                  .IMG_SERVICES_PLACEHOLDER,
                              width: 30.w,
                              color: Color(con
                                  .homeResponse!
                                  .products[index]
                                  .color!),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextRegular(
                            title: "تمويل",
                            color: ThemeClass.secondaryColor,
                            fontSize: 16.sp,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 6.h,),
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(16.w),
                            child: con
                                .homeResponse!
                                .products[index]
                                .titleImg !=
                                null
                                ? Image.network(con
                                .homeResponse!
                                .products[index]
                                .titleImg ??
                                "",width: 85.w,height: 20.h,)
                                : Image.asset(
                              AppAssets
                                  .IMG_SERVICES_PLACEHOLDER,
                              width: 30.w,),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
