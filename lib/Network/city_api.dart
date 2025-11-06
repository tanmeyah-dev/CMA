import 'package:Tanmeyah/Models/city_response.dart';
import 'package:Tanmeyah/Models/governorates_response.dart';

import 'api.dart';
import 'network_methods.dart';

class CityApi{
  static Future<List<Governorates>?> getGovernment() async {
    var response = await NetworkMethods.getRequest(
      url: API.getGovernorates,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
       GovernmentResponse governmentResponse = GovernmentResponse.fromJson(response);
       return governmentResponse.governorates;
    } else {
      return null;
    }
  }
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