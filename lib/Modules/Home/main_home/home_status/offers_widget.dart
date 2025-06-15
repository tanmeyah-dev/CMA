// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:Tanmeyah/Modules/Home/main_home/home_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../More/offer_detail/offer_details_screen.dart';
import '../../offers/main_offers/main_offers_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OffersWidget extends StatelessWidget {
  HomeController con;
  OffersWidget({Key? key,required this.con}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextRegular(
                  title: "best_offers".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w300,
                ),
                GestureDetector(
                  onTap: () async {
                    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                    _analytics.logEvent(
                        name: 'request_view_all_offers',
                        parameters: <String,dynamic>{
                          "title" :"request_view_all_offers"
                        }
                    );
                    Navigator.pushNamed(context, MainOffersScreen.routeName);
                  },
                  child: Row(
                    children: [
                      AppTextRegular(
                        title: "more_dot".tr,
                        color: ThemeClass.secondaryColor,
                      ),
                      Icon(
                        Icons.arrow_right_sharp,
                        color: ThemeClass.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ) ,

        SizedBox(
          height: 16.h,
        ),
         CarouselSlider(
            options: CarouselOptions(
                height: 130.h,
                autoPlay: true,
                viewportFraction: 0.9),
            items: con.homeResponse!.offers.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                      _analytics.logEvent(
                          name: 'open_offer_detail',
                          parameters: <String,dynamic>{
                            "title" :"open_offer_detail  ${i.nameAr}"
                          }
                      );
                      Navigator.pushNamed(context,
                          OfferDetailScreen.routeName,
                          arguments: i.id);
                    },
                    child: Container(
                        width: 328.w,
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w),
                        decoration: BoxDecoration(
                            image: i.imageUrl != null
                                ? DecorationImage(
                              image:
                              CachedNetworkImageProvider(
                                  i.imageUrl!),
                              fit: BoxFit.fitWidth,
                            )
                                : const DecorationImage(
                                image: AssetImage(
                                  AppAssets
                                      .IMG_PLACEHOLDER,
                                ),
                                fit: BoxFit.fitWidth),
                            borderRadius:
                            BorderRadius.circular(
                                24.w)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(24.w),
                            gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ThemeClass.fontColor
                                      .withOpacity(0.0),
                                  ThemeClass.fontColor,
                                ]),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h),
                          child: Align(
                            alignment:
                            Alignment.bottomRight,
                            child: AppTextBold(
                              title: '${i.title}',
                              color: ThemeClass.whiteColor,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )),
                  );
                },
              );
            }).toList(),
          ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
