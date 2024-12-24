// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Cache/app_languages.dart';
import '../../../Shared/shared_prefirences.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';
import '../ValidateUser/validate_user_screen.dart';
import 'content_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "/onBoardingScreen";

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
     _analytics.logEvent(
        name: 'open_onboarding_screen',
        parameters: <String,dynamic>{
          "title" : "open_onboarding_screen"
        }
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLan = Provider.of<AppLanguage>(context);
    appLan.fetchLocale();
    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h),
          child: Stack(
            children: [
              Column(
                children: [pageView(), nextAndBackButton(),SizedBox(height: 25.h,)],
              ),
              Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: SkipButton(
                    onTap: () async {
                      final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                      _analytics.logEvent(
                          name: 'skip_onboarding_screen',
                          parameters: <String,dynamic>{
                            "title" : "skip_onboarding_screen"
                          }
                      );
                      await SharedPref.saveWatchIntro();
                      Navigator.pushNamed(
                          context, ValidateUserScreen.routeName);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget pageView() {
    return Expanded(
      child: PageView.builder(
        controller: _controller,
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return Column(
            children: [
              SizedBox(height: 100.h),
              Image.asset(
                contents[i].image,
                height: 320.h,
                width: 320.w,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 40.h),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  )),
              SizedBox(height: 32.h),
              AppTextMedium(title: contents[i].title,fontWeight: FontWeight.w600,fontSize: 24.sp,),
              SizedBox(height: 60.h),
              Padding(padding: EdgeInsets.symmetric(horizontal: 40.w),
                 child : AppTextRegular(title: contents[i].discription,color: ThemeClass.borderColor,),
              )
            ],
          );
        },
      ),
    );
  }

  Widget nextAndBackButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentIndex != 0
              ? GestureDetector(
                  onTap: () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInQuad,
                    );
                  },
                  child: Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: ThemeClass.backgroundBackButton),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 6.h,right: 16.w),
                      child: Icon(Icons.arrow_back_ios,
                          color: ThemeClass.borderColor),),)
              : Container(),
          SizedBox(width: 10.w,),
          GestureDetector(
              onTap: () async {
                if (currentIndex == contents.length - 1) {
                  await SharedPref.saveWatchIntro();
                  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
                  _analytics.logEvent(
                      name: 'complete_onboarding_screen',
                      parameters: <String,dynamic>{
                        "title" : "complete_onboarding_screen"
                      }
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ValidateUserScreen.routeName,
                      (Route<dynamic> route) => false);
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInQuad,
                );
              },
              child: Container(
                  width: 126.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: ThemeClass.primaryColor),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h,right: 4.w ),
                          child: Text(
                            "next".tr,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: ThemeClass.whiteColor),
                          ),
                        ),
                        SizedBox(width: 6.w,),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ThemeClass.whiteColor,
                        )
                      ]))),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: 10.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index
            ? ThemeClass.primaryColor
            : ThemeClass.primaryLightPrimaryColor,
      ),
    );
  }
}
