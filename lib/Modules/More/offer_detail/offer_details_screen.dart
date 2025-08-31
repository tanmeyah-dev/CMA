// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/More/offer_detail/offer_detail_controller.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class OfferDetailScreen extends StatefulWidget {
  static const String routeName = "/offerDetailScreen";
  final int offerID;
  const OfferDetailScreen({Key? key, required this.offerID}) : super(key: key);

  @override
  _OfferDetailScreenState createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends StateMVC<OfferDetailScreen> {
  _OfferDetailScreenState() : super(OfferDetailController()) {
    con = OfferDetailController();
  }

  late OfferDetailController con;

  @override
  void initState() {
    con.offerId = widget.offerID;
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_offer_detail_screen',
        parameters: <String,dynamic>{
          "title" :"open_offer_detail_screen ${con.offerModel?.nameAr}"
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: con.offerModel?.nameAr ?? "",
      ),
      body: LoadingScreen(
        loading: con.loading,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: ThemeClass.whiteColor,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                     Container(
                          width: double.infinity,
                          height: 168.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.w),
                            image: con.offerModel?.imageUrl != null
                                ? DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      con.offerModel!.imageUrl!,
                                    ),
                                    fit: BoxFit.fitWidth)
                                : const DecorationImage(
                                    image: AssetImage(AppAssets.IMG_PLACEHOLDER),
                                    fit: BoxFit.fill),
                          ),
                      ),
                      SizedBox(
                        height: 10.h
                      ),
                       AppTextRegular(
                          title: con.offerModel?.nameAr??"",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                          height: 10.h
                      ),
                      AppTextRegular(
                          title: con.offerModel?.descriptionAr ?? "",
                          textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
