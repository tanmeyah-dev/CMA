import 'package:Tanmeyah/Models/Contact_us_model.dart';
import 'package:Tanmeyah/Utilities/general_toast.dart';
import 'package:flutter/cupertino.dart';
import 'api.dart';
import 'network_methods.dart';

class ContactUsApi {
  static Future<ContactUsResponse?> sendContactUs(BuildContext context , {ContactUsModel? contactUsModel}) async {
    var response = await NetworkMethods.postRequestAsRow(
        url: API.contactUs,
        body: contactUsModel!.toJson()
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return ContactUsResponse.fromJson(response);
    } else {
      ToastHelper.showError(context, message: response["message"]);
      return null;
    }
  }
}