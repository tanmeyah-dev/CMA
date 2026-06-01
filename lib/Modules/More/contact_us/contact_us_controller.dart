// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/Contact_us_model.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:Tanmeyah/Utilities/general_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Models/Contact_list_response.dart';
import '../../../Network/contact_us_api.dart';
import 'package:firebase_analytics/firebase_analytics.dart';



class ContactUsController extends ControllerMVC {
  // singleton
  factory ContactUsController() {
    _this ??= ContactUsController._();
    return _this!;
  }

  static ContactUsController? _this;

  ContactUsController._();
  String? phone;

  ContactListResponse? contactListResponse;
  String? selectChoose = null; // Explicitly initialize as null to show hint

  bool loading = false,
      autoValidate = false,editPhone = false;
  late TextEditingController  fullName,phoneController,messageController;
  late ContactUsResponse? contactUsResponse;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    fullName = TextEditingController();
    phoneController = TextEditingController();
    messageController = TextEditingController();
    if(SharedPref.getUserObg()?.mobileNumber != null) {
      phoneController.text = SharedPref.getUserObg()!.mobileNumber;
      fullName.text = SharedPref.getUserObg()!.fullName;
    }
    getContactList();
    super.initState();
  }

  @override
  void dispose() {
    fullName.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }


  Future getContactList() async {
    loading = true;
    setState(() {
    });
    contactListResponse = await ContactUsApi.getContactList();
    loading = false;
    setState(() {
    });
  }



  Future contactMessage({required BuildContext? context}) async {
    // Validate that lookup is selected
    if (selectChoose == null || selectChoose!.isEmpty) {
      ToastHelper.showError(context!, message: "يرجى اختيار تخصص الاستفسار");
      return;
    }

    if(!phoneController.text.startsWith("0")) {
      phone = "0${phoneController.text}";
      setState(() { });
    } else {
      phone = phoneController.text;
      setState(() { });
    }


    ContactUsModel? contactUsModel = ContactUsModel(
      phoneNumber: phone!, 
      name: fullName.text, 
      message: messageController.text,
      lookupId: selectChoose,
    );
    loading = true;
    setState(() {
    });
    contactUsResponse = await ContactUsApi.sendContactUs(context! ,contactUsModel: contactUsModel);
    loading = false;
    setState(() {});
    if (contactUsResponse?.isSuccess == true) {
      final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
      _analytics.logEvent(
          name: 'submit_contact_us_successfully',
          parameters: <String,Object>{
            "title" :"submit_contact_us_successfully"
          }
      );

      ToastHelper.showSuccess(context, message: contactUsResponse?.message??"");
      phoneController.text = "";
      fullName.text = "";
      messageController.text = "";
      selectChoose = null; // Reset dropdown to show hint
      setState(() {});
    }
  }


}