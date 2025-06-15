import 'dart:io';

import 'api.dart';
import 'network_methods.dart';

class SplashApi{

  static Future<bool?> sendVersion(String version) async {
    String platform = "";
    if (Platform.isAndroid) {
      platform = "2";
    } else if (Platform.isIOS) {
      platform = "1";
    }
    var response = await NetworkMethods.postRequestAsRow(
      url: API.checkVersion,
      body: {
        "version" : version,
         "platform" : platform
      },
    );
    if (response == null) return null;
    if (response["isSuccess"] == true && response["newUpdateAvailable"] == true && response["isForcedUpdate"] == true){
      return true;
    } else {
      return false;
    }
  }

}