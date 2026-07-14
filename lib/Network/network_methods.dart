// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Shared/shared_prefirences.dart';
import '../Utilities/general_toast.dart';
import '../Utilities/device_id_helper.dart';
import 'api.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bot_toast/bot_toast.dart';

class NetworkMethods {
  static void _applyAuthHeader(
    Map<String, String> headers, {
    bool skipAuthHeader = false,
  }) {
    if (skipAuthHeader) return;

    final hasAuthHeader = headers.keys.any(
      (key) => key.toLowerCase() == 'authorization',
    );
    if (hasAuthHeader) return;

    final token = SharedPref.getAuthToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = token;
    }
  }

  static Future postRequestAsRow(
      {required String url,
      String? customUrl,
      required Map body,
      Map<String, String>? headers,
      BuildContext? context,
      bool suppressAuthRedirect = false,
      bool skipAuthHeader = false}) async {
    final checkConnection = await Connectivity().checkConnectivity();
    final hasConnection = checkConnection
        .any((result) => result != ConnectivityResult.none);
    if (hasConnection) {
      debugPrint(body.toString());
      debugPrint(customUrl ?? "${API.baseURL}$url");

      var request = http.Request(
        'POST',
        Uri.parse(customUrl ?? '${API.baseURL}$url'),
      );
      request.body = json.encode(body);

      headers ??= {};

      // Get device ID - ensure it's always included
      String deviceId = await DeviceIdHelper.getDeviceId();

      // Add standard headers
      headers.addAll({
        'Content-Type': 'application/json',
        "Accept": "application/json",
      });

      // Add device ID last to ensure it's always present (even if custom headers try to override)
      headers["Device-Id"] = deviceId;
      _applyAuthHeader(headers, skipAuthHeader: skipAuthHeader);

      debugPrint(headers.toString());
      request.headers.addAll(headers);
      try {
        http.StreamedResponse response =
            await request.send().timeout(const Duration(seconds: 100));
        String result = await response.stream.bytesToString();
        log(response.statusCode.toString());
        log("api response >>>>>>>>>>>>>>>>>>>>>>>>:${result.toString()}");
        if (response.statusCode == 401 && !suppressAuthRedirect) {
          await SharedPref.logOut();
          Modular.to.pushNamedAndRemoveUntil(
            "/validateUser",
            (Route<dynamic> route) => false,
          );
        }
        if (response.statusCode == 429) {
          BotToast.showText(
              text:
                  "لقد استنفذت الحد الاقصي من المحاولات .. برجاء المحاوله لاحقا");
          return null;
        }
        try {
          return json.decode(result);
        } catch (e) {
          log("cccccccccsdsdsdsdsd$e");
          return null;
        }
      } on TimeoutException catch (_) {
        log("⏰ Request timed out");
        if (context != null) {
          return ToastHelper.showError(context,
              message: "Request timed out. Please try again.");
        }
        return null;
      } catch (e) {
        BotToast.showText(text: "برجاء التحقق من الاتصال بالانترنت");
        if (context != null) {
          return ToastHelper.showError(context,
              message: "Something went wrong. Please try again.");
        }
        return null;
      }
    } else {
      Modular.to.pushNamedAndRemoveUntil(
        "/noInternetScreen",
        (Route<dynamic> route) => false,
      );
    }
  }

  static Future getRequest({
    required String url,
    Map<String, String>? headers,
    bool suppressAuthRedirect = false,
    bool skipAuthHeader = false,
  }) async {
    final checkConnection = await Connectivity().checkConnectivity();
    final hasConnection = checkConnection
        .any((result) => result != ConnectivityResult.none);
    if (hasConnection) {
      debugPrint('${API.baseURL}$url');
      var request = http.Request('GET', Uri.parse('${API.baseURL}$url'));

      // Get device ID - ensure it's always included
      String deviceId = await DeviceIdHelper.getDeviceId();

      // Add standard headers
      request.headers.addAll({
        'Content-Type': 'application/json',
        "Accept": "application/json",
      });

      headers ??= {};
      request.headers.addAll(headers);

      // Add device ID last to ensure it's always present (even if custom headers try to override)
      request.headers["Device-Id"] = deviceId;
      _applyAuthHeader(request.headers, skipAuthHeader: skipAuthHeader);
      http.StreamedResponse response;
      try {
        response = await request.send().timeout(const Duration(seconds: 10));
        String result = await response.stream.bytesToString();
        log(response.statusCode.toString());
        log(result.toString());
        if (response.statusCode == 401 && !suppressAuthRedirect) {
          await SharedPref.logOut();
          Modular.to.pushNamedAndRemoveUntil(
            "/validateUser",
            (Route<dynamic> route) => false,
          );
        }
        if (response.statusCode == 429) {
          BotToast.showText(
              text:
                  "لقد استنفذت الحد الاقصي من المحاولات .. برجاء المحاوله لاحقا");
          return null;
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
      } on SocketException catch (_) {
        log("❌ Socket/network error");
        BotToast.showText(text: "برجاء التحقق من الاتصال بالانترنت");
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
      Modular.to.popAndPushNamed("/noInternetScreen");
    }
  }
}

class MultipartRequest extends http.MultipartRequest {
  MultipartRequest(
    super.method,
    super.url, {
    required this.onProgress,
  });
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
