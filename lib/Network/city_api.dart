import 'package:Tanmeyah/Models/city_response.dart';

import 'api.dart';
import 'network_methods.dart';

class CityApi{
  static Future<CityResponse?> getCityByGovernerate({required String governorateId}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.getBranchWithCites,
      body: {
        "governorateId" : governorateId,
      },
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return CityResponse.fromJson(response);
    } else {
      return null;
    }
  }
}