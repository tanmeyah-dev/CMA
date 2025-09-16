import 'package:Tanmeyah/Models/loan_products_response.dart';
import 'api.dart';
import 'network_methods.dart';

class LoanProductsApi {
  static Future<LoanProductsResponse?> getLoanProducts() async {
    var response = await NetworkMethods.getRequest(
        url: API.getLoanProducts,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return LoanProductsResponse.fromJson(response);
    } else {
      return null;
    }
  }
}