import 'package:Tanmeyah/Models/Bill_Inquiry_Response.dart';
import 'package:Tanmeyah/Models/biller_services_response.dart';
import 'package:Tanmeyah/Models/get_all_services_response.dart';
import 'package:Tanmeyah/Models/mobile_biller_response.dart';

import '../Models/services_model.dart';
import 'api.dart';
import 'network_methods.dart';

class BillersApi{


  static Future<GetAllServicesResponse?> getAllServices() async {
    var response = await NetworkMethods.getRequest(
      url: API.getServiceType,
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return GetAllServicesResponse.fromJson(response);
    } else {
      return null;
    }
  }

  static Future<MobileBillersResponse?> getBillers({required String billerID}) async {
    var response = await NetworkMethods.getRequest(
      url: API.getBillers+"$billerID",
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return MobileBillersResponse.fromJson(response);
    } else {
      return null;
    }
  }


  static Future<BillerServicesResponse?> getBillerServices({required String billerID,required String phoneNumber}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.getBillerServices,
      body: {
        "billerId" : billerID,
        "userPhoneNumber" : phoneNumber,
      }
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return BillerServicesResponse.fromJson(response);
    } else {
      return null;
    }
  }


  static Future excuteDailyJob() async {
    var response = await NetworkMethods.getRequest(
      url: API.excuteDailyJob,
    );

    print("We Hitted The JOB");
  }


  static Future<BillInquiryResponse?> getBillInquiry({required phoneNumber,required billerId,required billTypeCode,required paymentType}) async {
    var response = await NetworkMethods.postRequestAsRow(
      url: API.getBillInquiry,
      body: {
        "billTypeCode" : billTypeCode,
        "billerId" : billerId,
        "billingAcct" : "0120000200",
        "incOpenAmt" : true,
        "paymentType" : paymentType,
        "userPhoneNumber" : phoneNumber
      },
    );
    if (response == null) return null;
    if (response["isSuccess"] == true) {
      return BillInquiryResponse.fromJson(response);
    } else {
      return null;
    }
  }




}