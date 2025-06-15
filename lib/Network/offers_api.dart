import 'package:Tanmeyah/Models/offers_model.dart';
import 'api.dart';
import 'network_methods.dart';

class OffersApi{
  static Future<OffersResponse?> getOffers() async {
    var response = await NetworkMethods.getRequest(
      url: API.offer,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return OffersResponse.fromJson(response);
    } else {
      return null;
    }
  }


  static Future<OfferModel?> getOfferDetail({required String offerId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.offerDetail,
      body: {
        "id" : offerId
      },
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return OfferModel.fromJson(response["offer"]);
    } else {
      //ToastHelper.showError(message: response["message"]);
      return null;
    }
  }
}