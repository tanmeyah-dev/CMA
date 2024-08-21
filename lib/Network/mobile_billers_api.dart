import 'package:Tanmeyah/Models/biller_services_response.dart';
import 'package:Tanmeyah/Models/mobile_biller_response.dart';

import '../Models/services_model.dart';
import 'api.dart';
import 'network_methods.dart';

class BillersApi{

  static Future<MobileBillersResponse?> getBillers({required String billerID}) async {
    var response = await NetworkMethods.getRequest(
      url: API.getBillers+"$billerID",
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return MobileBillersResponse.fromJson(response);
    } else {
      return null;
    }
  }


  static Future<BillerServicesResponse?> getBillerServices({required String billerID}) async {
    var response = await NetworkMethods.getRequest(
      url: API.getBillerServices+"$billerID",
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return BillerServicesResponse.fromJson(response);
    } else {
      return null;
    }
  }

}