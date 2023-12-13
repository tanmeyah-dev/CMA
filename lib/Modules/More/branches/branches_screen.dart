// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors
import 'package:Tanmeyah/Modules/More/branches/branch_widget.dart';
import 'package:Tanmeyah/Modules/More/branches/branches_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:Tanmeyah/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Widgets/base_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:iconsax/iconsax.dart';


class BranchesScreen extends StatefulWidget {
  static const String routeName = "/branchesScreen";

  const BranchesScreen({Key? key}) : super(key: key);

  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends StateMVC<BranchesScreen> {
  _BranchesScreenState() : super(BranchesController()) {
    con = BranchesController();
  }

  late BranchesController con;
  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_branches_screen',
        parameters: <String,dynamic>{
          "title" :"open_branches_screen"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      appBar: BaseAppBar.main(
        title: "branches".tr,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: LoadingScreen(
          loading: con.loading,
          child: Column(children: [
            SizedBox(
              height: 18.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              color: ThemeClass.whiteColor,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) async {
                        await con.onRefresh();
                      },
                      controller: con.searchController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.w),
                          borderSide: BorderSide(
                            width: 1.sp,
                            color: ThemeClass.primaryColor,
                          ),
                        ),
                        suffixIcon: Icon(
                          Iconsax.search_normal_1,
                          color: ThemeClass.primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ThemeClass.hintColor, width: 1.sp),
                          borderRadius: BorderRadius.circular(
                            12.w,
                          ),
                        ),
                        hintText: "search".tr,
                        hintStyle: TextStyle(
                          color: ThemeClass.hintColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 10.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            SizedBox(
              height: 610.h,
              child: (con.branchList != null && con.branchList.isNotEmpty)
                  ? SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus? mode) {
                          if (mode == LoadStatus.idle) {
                            return SizedBox(
                                height: 50.h,
                                child: Center(child: Text("swipe_load".tr)));
                          } else if (mode == LoadStatus.loading) {
                            return SizedBox(
                                height: 50.h,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: ThemeClass.primaryColor,
                                )));
                          }
                          return const SizedBox();
                        },
                      ),
                      controller: con.refreshController!,
                      onRefresh: con.onRefresh,
                      onLoading: con.onLoading,
                      child: ListView.separated(
                          itemBuilder: (_, index) {
                            return BranchWidget(
                              branchModel: con.branchList[index],
                            );
                          },
                          separatorBuilder: (_, index) {
                            return SizedBox(
                              height: 8.h,
                            );
                          },
                          itemCount: con.branchList.length),
                    )
                  :

              Center(
                        child: Container(
                            alignment: Alignment.center,
                            height: 500.h,
                            child: AppTextRegular(
                              title: 'no_branches'.tr,
                              fontSize: 20.sp,
                            ))),
            ),
          ]),
        ),
      ),
    );
  }


  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&mode=d';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
