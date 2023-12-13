import '../Models/services_model.dart';
import 'api.dart';
import 'network_methods.dart';

class ServiceApi{

  static Future<ServicesResponse?> getServices() async {
    var response = await NetworkMethods.getRequest(
      url: API.services,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return ServicesResponse.fromJson(response);
    } else {
      return null;
    }
  }

}