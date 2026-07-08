// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/faq_response.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Network/faq_api.dart';


class FAQController extends ControllerMVC {
  // singleton
  factory FAQController() {
    _this ??= FAQController._();
    return _this!;
  }

  static FAQController? _this;

  FAQController._();

  bool loading = false, autoValidate = false;

  FAQResponse? faqResponse;

  @override
  void initState() {
    getFAQQuestion();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getFAQQuestion() async {
    loading = true;
    setState(() {
    });
    faqResponse = await FaqAPI.getFAQQuestions();
    loading = false;
    setState(() {
    });
  }


}
