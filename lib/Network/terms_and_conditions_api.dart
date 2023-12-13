import 'dart:convert';

import '../Models/terms_response.dart';
import '../Shared/shared_prefirences.dart';
import 'api.dart';
import 'package:http/http.dart' as http;


class TermsAndConditionsApi{

  static Future getTermsData() async {
    var url = Uri.parse(API.baseURL + API.terms);
    http.Response response = await http.get(url,headers: {
      'Content-Type': 'application/json',
      "Accept" : "application/json",
      "Authorization" : (SharedPref.getUserObg() == null) ? "${SharedPref.getGuestToken()}" : "${SharedPref.getUserObg()?.token}",
    });
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
    var url = Uri.parse(API.baseURL + API.conditions);
    http.Response response = await http.get(url,headers: {
      'Content-Type': 'application/json',
      "Accept" : "application/json",
      "Authorization" : (SharedPref.getUserObg() == null) ? "${SharedPref.getGuestToken()}" : "${SharedPref.getUserObg()?.token}",
    });
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