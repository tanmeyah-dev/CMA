import 'dart:convert';

import '../Models/terms_response.dart';
import '../Shared/shared_prefirences.dart';
import '../Utilities/device_id_helper.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'package:bot_toast/bot_toast.dart';


class TermsAndConditionsApi{

  static Map<String, String> _buildHeaders(String deviceId) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Device-Id": deviceId,
    };
    final authToken = SharedPref.getAuthToken();
    if (authToken != null && authToken.isNotEmpty) {
      headers['Authorization'] = authToken;
    }
    return headers;
  }

  static Future getTermsData() async {
    String deviceId = await DeviceIdHelper.getDeviceId();
    var url = Uri.parse(API.baseURL + API.terms);
    http.Response response = await http.get(url, headers: _buildHeaders(deviceId));
    if(response.statusCode == 429){
      BotToast.showText(text:"لقد استنفذت الحد الاقصي من المحاولات .. برجاء المحاوله لاحقا");
      return 'failed';
    }
    try {
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        return MessageResponse.fromJson(decodedData);
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  static Future getConditionsData() async {
    String deviceId = await DeviceIdHelper.getDeviceId();
    var url = Uri.parse(API.baseURL + API.conditions);
    http.Response response = await http.get(url, headers: _buildHeaders(deviceId));
    if(response.statusCode == 429){
      BotToast.showText(text:"لقد استنفذت الحد الاقصي من المحاولات .. برجاء المحاوله لاحقا");
      return 'failed';
    }
    try {
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        return MessageResponse.fromJson(decodedData);
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }
}
