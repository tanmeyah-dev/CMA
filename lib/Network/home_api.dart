import 'package:Tanmeyah/Models/home_response.dart';
import 'api.dart';
import 'network_methods.dart';

class HomeApi {
  static Future<HomeResponse?> getHomeData({String? nationalId}) async {
    var response = await NetworkMethods.postRequestAsRow(
        url: API.home,
        body: {
          "nationalId": "$nationalId",
        }
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return HomeResponse.fromJson(response);
    } else {
      return null;
    }
  }
}