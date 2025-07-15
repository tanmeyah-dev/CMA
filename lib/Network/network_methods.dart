// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Shared/shared_prefirences.dart';
import '../Utilities/general_toast.dart';
import 'api.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:bot_toast/bot_toast.dart';



class NetworkMethods {

  
  static Future postRequestAsRow(
      {required String url,
        String? customUrl,
        required Map body,
        Map<String, String>? headers,
        BuildContext? context}) async {

    var checkConnection = await Connectivity().checkConnectivity();
    if(checkConnection != ConnectivityResult.none) {
      debugPrint(body.toString());
      debugPrint(customUrl??"${API.baseURL}$url");

      var request = http.Request(
        'POST',
        Uri.parse(customUrl??'${API.baseURL}$url'),
      );
      request.body = json.encode(body);

      headers ??= {};

      headers.addAll({
        'Content-Type': 'application/json',
        "Accept" : "application/json",
        "Authorization" : (SharedPref.getUserObg() == null) ? "${SharedPref.getGuestToken()}" : "${SharedPref.getUserObg()?.token}",
      });
      debugPrint(headers.toString());
      request.headers.addAll(headers);
      try {
        http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 100));
        String result = await response.stream.bytesToString();
        log(response.statusCode.toString());
        log("api response >>>>>>>>>>>>>>>>>>>>>>>>:${result.toString()}");
        if(response.statusCode == 401){
          await SharedPref.logOut();
          Modular.to.pushNamedAndRemoveUntil(
              "/loginScreen", (Route<dynamic> route) => false,
              arguments: "");
        }
        try {
          return json.decode(result);
        } catch (e) {
          log("cccccccccsdsdsdsdsd$e");
          return null;
        }
      }
      on TimeoutException catch (_) {
        log("⏰ Request timed out");
        if (context != null) {
         return ToastHelper.showError(context, message: "Request timed out. Please try again.");
        }
        return null;
      } catch (e) {
        BotToast.showText(text:"برجاء التحقق من الاتصال بالانترنت");
        if (context != null) {
         return  ToastHelper.showError(context, message: "Something went wrong. Please try again.");
        }
        return null;
      }
    }
    else {
      Modular.to.pushNamedAndRemoveUntil(
          "/noInternetScreen", (Route<dynamic> route) => false,);
    }


  }

  static Future getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    var checkConnection = await Connectivity().checkConnectivity();
    if(checkConnection != ConnectivityResult.none) {
    debugPrint('${API.baseURL}$url');
    var request = http.Request('GET', Uri.parse('${API.baseURL}$url'));
      request.headers.addAll({
        'Content-Type': 'application/json',
        "Accept" : "application/json",
        "Authorization" : (SharedPref.getUserObg() == null) ? "${SharedPref.getGuestToken()}" : "${SharedPref.getUserObg()?.token}",
      });
    if (headers != null) request.headers.addAll(headers);
    http.StreamedResponse response;
    try {
      response =
      await request.send().timeout(const Duration(seconds: 10));
      String result = await response.stream.bytesToString();
      log(response.statusCode.toString());
      log(result.toString());
      if(response.statusCode == 401){
        await SharedPref.logOut();
        Modular.to.pushNamedAndRemoveUntil(
            "/loginScreen", (Route<dynamic> route) => false,
            arguments: "");
      }
      try {
        return json.decode(result);
      } catch (e) {
        log("❌ JSON decoding error: $e");
        return null;
      }
    } on TimeoutException catch (_) {
      log("⏰ Request timed out");
      // if (context != null) {
      //   ToastHelper.showError(context, message: "Request timed out. Please try again.");
      // }
      return null;
    }  on SocketException catch (_) {
      log("❌ Socket/network error");
      BotToast.showText(text:"برجاء التحقق من الاتصال بالانترنت");
      // if (context != null) {
      //   ToastHelper.showError(context, message: "Network error. Please check your connection.");
      // }
      return null;
    } catch (e) {
      log("❌ Unexpected error: $e");
      // if (context != null) {
      //   ToastHelper.showError(context, message: "An unexpected error occurred.");
      // }
      return null;
    }
      // return json.decode(result);
    } else {
      Modular.to.popAndPushNamed(
        "/noInternetScreen");
    }

  }


}

class MultipartRequest extends http.MultipartRequest {
  MultipartRequest(
      String method,
      Uri url, {
        required this.onProgress,
      }) : super(method, url);
  final void Function(int bytes, int totalBytes) onProgress;

  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        if (total >= bytes) {
          sink.add(data);
        }
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
