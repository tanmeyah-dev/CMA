// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/More/offer_detail/offer_details_screen.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Theme/themeclass.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../../Widgets/custom_text.dart';
import '../../offers/main_offers/main_offers_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MainOffersScreen extends StatefulWidget {
  static const String routeName = "/mainOffersScreen";

  const MainOffersScreen({Key? key}) : super(key: key);

  @override
  _MainOffersScreenState createState() => _MainOffersScreenState();
}

class _MainOffersScreenState extends StateMVC<MainOffersScreen> {
  _MainOffersScreenState() : super(MainOffersController()) {
    con = MainOffersController();
  }

  late MainOffersController con;


  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_offers_screen',
        parameters: <String,Object>{
          "title" :"open_offers_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "offers".tr,
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: !con.loading ?  Container (
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: ThemeClass.whiteColor,
            width: double.infinity,
            height: double.infinity,
            child: (con.offersResponse?.offers != null  && con.offersResponse!.offers.isNotEmpty)?
              Column(
                children: [
                  SizedBox(height: 20.h,),
                  Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return  GestureDetector(
                            onTap: () {
                              final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                              _analytics.logEvent(
                                  name: 'open_offers_detail',
                                  parameters: <String,Object>{
                                    "title" :"open_offers_detail ${con.offersResponse?.offers[index].nameAr}"
                                  }
                              );
                              Navigator.pushNamed(context, OfferDetailScreen.routeName,arguments: con.offersResponse?.offers[index].id);
                             },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 130.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.w),
                                    image: con.offersResponse?.offers[index].imageUrl != null ?   DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          con.offersResponse!.offers[index].imageUrl!,
                                        ),
                                        fit: BoxFit.fitWidth) : const DecorationImage(image: AssetImage(AppAssets.IMG_PLACEHOLDER),fit: BoxFit.fill),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 22.h,horizontal: 30.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.w),
                                      gradient:  LinearGradient(
                                          begin: Alignment.center,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            ThemeClass.blackColor.withOpacity(0.09),
                                            ThemeClass.blackColor.withOpacity(0.9),
                                          ]),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional.bottomStart,
                                      child: AppTextBold(title :con.offersResponse?.offers[index].nameAr??"",color: ThemeClass.whiteColor,fontWeight: FontWeight.bold,fontSize: 24.sp,),
                                    ),
                                  ),
                                ),
                                // con.offersResponse?.offers[index].title != null ? FadeIn(
                                //     delay: 2,
                                //     from: SlideFrom.RIGHT,
                                //     child: AppTextRegular(title: con.offersResponse?.offers[index].title??"")) : Container(),
                              ],
                            ),
                          );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                            height: 20.h
                        );
                      },
                      itemCount: con.offersResponse!.offers.length),
            ),
                ],
              ) :     Container(
                alignment: Alignment.center,
                color: ThemeClass.whiteColor,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Image.asset(
                            AppAssets.IMG_EMPTY_OFFERS,
                            width: 350.w,
                            height: 350.h,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                          AppTextRegular(
                            title: "empty_offers".tr,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                            color: ThemeClass.primaryColor,
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                24.sp,
                              ),
                              color: ThemeClass.primaryColor,
                            ),
                            padding:
                            EdgeInsets.symmetric(vertical: 4.h, horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: ThemeClass.whiteColor,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: AppTextMedium(title: "back".tr,color: ThemeClass.whiteColor,)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )),
          ) : Container(),
        ),
      ),
    );
  }

}
