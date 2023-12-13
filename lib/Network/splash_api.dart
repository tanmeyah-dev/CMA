import 'api.dart';
import 'network_methods.dart';

class SplashApi{

  static Future<String?> getAppVersion() async {
    var response = await NetworkMethods.getRequest(
      url: API.version,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return response["version"];
    } else {
      return null;
    }
  }

}