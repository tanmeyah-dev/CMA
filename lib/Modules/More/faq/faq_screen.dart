// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/More/faq/faq_controller.dart';
import 'package:Tanmeyah/Theme/app_assets.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:Tanmeyah/Widgets/base_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Utilities/loading_screen.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'faq_widget.dart';


class FAQScreen extends StatefulWidget {
  static const String routeName = "/faqScreen";
  const FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends StateMVC<FAQScreen> {
  _FAQScreenState() : super(FAQController()) {
    con = FAQController();
  }

  late FAQController con;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.main(
        title: "faq".tr,
      ),
      body: con.faqResponse?.faqs != null ? ListView.builder(
        itemCount: con.faqResponse?.faqs?.length,
        itemBuilder: (context, index) {
          return Card(
            color: ThemeClass.termsBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            margin:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // 👈 This hides the gray border
              ),
              child: ExpansionTile(
                title: HtmlWidget(
                  con.faqResponse!.faqs![index].question??"",
                ),
                iconColor: Colors.grey[700],
                collapsedIconColor: Colors.grey[700],
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: HtmlWidget(
                      con.faqResponse!.faqs![index].answer??"",
                    ),
                  ),
                ],
              ),
            ),
          ) ;
        },
      ): Container(),
    );
  }
}
