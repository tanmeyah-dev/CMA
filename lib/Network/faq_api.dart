import 'package:Tanmeyah/Models/faq_response.dart';

import 'api.dart';
import 'network_methods.dart';

class FaqAPI {
  static Future<FAQResponse?> getFAQQuestions() async {
    var response = await NetworkMethods.getRequest(
      url: API.getFAQ,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return  FAQResponse.fromJson(response);
    } else {
      return null;
    }
  }
}