// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../Shared/shared_prefirences.dart';
import 'api.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:connectivity_plus/connectivity_plus.dart';




class NetworkMethods {
  
  // Cache authorization header to avoid repeated SharedPref calls
  static String? _cachedAuthHeader;
  static DateTime? _lastAuthUpdate;
  
  // Get cached authorization header
  static String _getCachedAuthHeader() {
    // Update cache every 5 minutes or if not cached
    if (_cachedAuthHeader == null || 
        _lastAuthUpdate == null || 
        DateTime.now().difference(_lastAuthUpdate!) > const Duration(minutes: 5)) {
      _cachedAuthHeader = (SharedPref.getUserObg() == null) 
          ? "${SharedPref.getGuestToken()}" 
          : "${SharedPref.getUserObg()?.token}";
      _lastAuthUpdate = DateTime.now();
    }
    return _cachedAuthHeader ?? "";
  }
  
  // Clear auth header cache (call after login/logout)
  static void clearAuthHeaderCache() {
    _cachedAuthHeader = null;
    _lastAuthUpdate = null;
  }
  
  // Background JSON encoding
  static Future<String> _encodeJsonInBackground(Map body) async {
    // Only use compute for large objects to avoid overhead
    if (body.toString().length > 1000) {
      return await compute(_encodeJson, body);
    }
    return json.encode(body);
  }
  
  // Background JSON decoding
  static Future<dynamic> _decodeJsonInBackground(String jsonString) async {
    // Only use compute for large strings to avoid overhead
    if (jsonString.length > 1000) {
      return await compute(_decodeJson, jsonString);
    }
    return json.decode(jsonString);
  }
  
  // Static methods for compute
  static String _encodeJson(Map body) => json.encode(body);
  static dynamic _decodeJson(String jsonString) => json.decode(jsonString);
  
  static Future postRequestAsRow(
      {required String url,
        String? customUrl,
        required Map body,
        Map<String, String>? headers,
        BuildContext? context}) async {

    // Check connectivity with error handling
    ConnectivityResult? checkConnection;
    try {
      checkConnection = await Connectivity().checkConnectivity();
    } catch (e) {
      print('Network connectivity check failed: $e');
      // Fallback: assume internet is available if connectivity check fails
      checkConnection = ConnectivityResult.wifi;
    }
    
    if(checkConnection != ConnectivityResult.none) {
      // Only log in debug mode to avoid performance impact
      if (kDebugMode) {
        debugPrint(body.toString());
        debugPrint(customUrl??"${API.baseURL}$url");
      }

      var request = http.Request(
        'POST',
        Uri.parse(customUrl??'${API.baseURL}$url'),
      );
      // Use compute for heavy JSON encoding in background
      request.body = await _encodeJsonInBackground(body);

      headers ??= {};

      headers.addAll({
        'Content-Type': 'application/json',
        "Accept" : "application/json",
        "Authorization" : _getCachedAuthHeader(),
      });
      if (kDebugMode) {
        debugPrint(headers.toString());
      }
      request.headers.addAll(headers);
      
      try {
        http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 30)); // Reduced timeout
        String result = await response.stream.bytesToString();
        
        if (kDebugMode) {
          log(response.statusCode.toString());
          log("api response >>>>>>>>>>>>>>>>>>>>>>>>:${result.toString()}");
        }
      if(response.statusCode == 401){
        await SharedPref.logOut();
        Modular.to.pushNamedAndRemoveUntil(
            "/loginScreen", (Route<dynamic> route) => false,
            arguments: "");
      }

        try {
          // Use compute for heavy JSON decoding in background
          return await _decodeJsonInBackground(result);
        } catch (e) {
          if (kDebugMode) {
            log("JSON decode error: $e");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) {
          log("Network request error: $e");
        }
        return null;
      }
    }
    else {
      Modular.to.pushNamedAndRemoveUntil(
          "/noInternetScreen", (Route<dynamic> route) => false);
      return null;
    }


  }

  static Future getRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    // Check connectivity with error handling
    ConnectivityResult? checkConnection;
    try {
      checkConnection = await Connectivity().checkConnectivity();
    } catch (e) {
      print('Network connectivity check failed: $e');
      // Fallback: assume internet is available if connectivity check fails
      checkConnection = ConnectivityResult.wifi;
    }
    
    if(checkConnection != ConnectivityResult.none) {
    debugPrint('${API.baseURL}$url');
    var request = http.Request('GET', Uri.parse('${API.baseURL}$url'));
      request.headers.addAll({
        'Content-Type': 'application/json',
        "Accept" : "application/json",
        "Authorization" : _getCachedAuthHeader(),
      });
    if (headers != null) request.headers.addAll(headers);
    http.StreamedResponse response;
    try {
      response =
      await request.send().timeout(const Duration(seconds: 10));
    } on TimeoutException {
      // ToastHelper.showError( message: "network_connection".tr);
      return null;
    } on SocketException {
      // ToastHelper.showError(message: "server_error".tr);
      return null;
    }

    String result = await response.stream.bytesToString();
    log(response.statusCode.toString());
    // if(response.statusCode == 401 ){
    //   Modular.to.pushNamedAndRemoveUntil(
    //       "/loginScreen", (Route<dynamic> route) => false,arguments: "");
    // }
    log(result.toString());

      if(response.statusCode == 401){
        await SharedPref.logOut();
        Modular.to.pushNamedAndRemoveUntil(
            "/loginScreen", (Route<dynamic> route) => false,
            arguments: "");
      }
      return await _decodeJsonInBackground(result);
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
