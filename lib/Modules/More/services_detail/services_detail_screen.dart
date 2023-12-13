// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/More/services_detail/services_detail_controller.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../Models/services_model.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';import 'package:firebase_analytics/firebase_analytics.dart';



class ServicesDetailScreen extends StatefulWidget {
  static const String routeName = "/servicesDetailScreen";
  final ServiceDetailModel serviceDetailModel;

  const ServicesDetailScreen({Key? key, required this.serviceDetailModel})
      : super(key: key);

  @override
  _ServicesDetailScreenState createState() => _ServicesDetailScreenState();
}

class _ServicesDetailScreenState extends StateMVC<ServicesDetailScreen> {
  _ServicesDetailScreenState() : super(ServicesDetailController()) {
    con = ServicesDetailController();
  }

  late ServicesDetailController con;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_services_detail_screen',
        parameters: <String,dynamic>{
          "title" :"open_services_detail_screen ${con.serviceDetailModel?.nameAr}"
        }
    );
    con.serviceId = widget.serviceDetailModel.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      appBar: BaseAppBar.main(
        title: "services".tr,
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              color: ThemeClass.whiteColor,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    Container(
                      width: 328.w,
                      decoration: BoxDecoration(
                        color: Color(widget.serviceDetailModel.color!)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24.sp),
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          widget.serviceDetailModel.imageUrl != null
                              ? Image.network(
                                  widget.serviceDetailModel.imageUrl!,
                                  width: 36.w,
                                  height: 36.h,
                                  color:
                                      Color(widget.serviceDetailModel.color!),
                                )
                              : Image.asset(
                                  AppAssets.IMG_SERVICES_PLACEHOLDER,
                                  width: 36.w,
                                  height: 36.h,
                                  color:
                                      Color(widget.serviceDetailModel.color!),
                                ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 240.w,
                            child: AppTextRegular(
                              title: widget.serviceDetailModel.nameAr ?? "",
                              color: Color(widget.serviceDetailModel.color!),
                              fontSize: 20.sp,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppTextBold(
                      title: con.serviceDetailModel?.title ?? "",
                      textAlign: TextAlign.start,
                      color: ThemeClass.blackColor,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    AppTextRegular(
                      title: con.serviceDetailModel?.descriptionAr ?? "",
                      textAlign: TextAlign.start,
                    ),
                    (con.serviceDetailModel?.info != null &&
                            con.serviceDetailModel!.info!.isNotEmpty)
                        ? ListView.separated(
                             shrinkWrap: true ,
                             physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16.h,),
                                  con.serviceDetailModel!
                                      .info![index].infoKey != null ? AppTextRegular(
                                    title: con.serviceDetailModel!
                                            .info![index].infoKey ??
                                        "",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ) : Container(),
                                  SizedBox(height: 20.h,),
                                  con.serviceDetailModel!
                                      .info![index].infoValue != null ?  HtmlWidget(con.serviceDetailModel!
                                      .info![index].infoValue ??
                                      "",textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp
                                  ),) : Container(),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  con.serviceDetailModel!.info![index]
                                      .imageUrl != null ?  Container(
                                    height : 160.h,
                                    decoration: BoxDecoration(
                                        image:  DecorationImage(
                                     image:
                                           CachedNetworkImageProvider(
                                          con.serviceDetailModel!.info![index]
                                              .imageUrl ??
                                              "",
                                        ),
                                          fit: BoxFit.fill
                                        ),
                                      borderRadius: BorderRadius.circular(16.w)
                                    ),
                                  ) : Container(),
                                ],
                              );
                            },
                            separatorBuilder: (_, index) {
                              return SizedBox(
                                height: 2.h,
                              );
                            },
                            itemCount:
                                con.serviceDetailModel!.info!.length,
                        )
                        : Container(),
                     SizedBox(height: 20.h,),

                  ],
                ),
              ),
            ),
          ),
          ),
        ),
    );
  }
}
