import 'package:Tanmeyah/Modules/Home/main_home/home_controller.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import '../../../../Theme/app_assets.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../More/services_detail/services_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class ProductsWidget extends StatelessWidget {
  final HomeController con;
  const ProductsWidget({super.key, required this.con});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Align(
                alignment: Alignment.centerRight,
                child: AppTextRegular(
                  title: "services".tr,
                  fontSize: 20.sp,
                )),
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
                  // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
                  // analytics.logEvent(
                  //     name: 'request_service',
                  //     parameters: <String,dynamic>{
                  //       "title" :"request_service_with  ${con.homeResponse?.products[index].nameAr}"
                  //     }
                  // );
                  Navigator.pushNamed(context,
                      ServicesDetailScreen.routeName,
                      arguments: con
                          .homeResponse!.products[index]);
                },
                child:  Container(
                    width: 354.w,
                    padding: EdgeInsets.symmetric(
                        vertical: 22.h, horizontal: 30.w),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(20.w),
                      color: Color(con.homeResponse!
                          .products[index].color!)
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
                                .imageUrl !=
                                null
                                ? Image.network(con
                                .homeResponse!
                                .products[index]
                                .imageUrl ??
                                "")
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
                            height: 45.h,
                          ),
                          AppTextRegular(
                            title: con
                                .homeResponse
                                ?.products[index]
                                .nameAr ??
                                "",
                            color: Color(con.homeResponse!
                                .products[index].color!),
                            textAlign: TextAlign.start,

                          ),
                        ],
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
