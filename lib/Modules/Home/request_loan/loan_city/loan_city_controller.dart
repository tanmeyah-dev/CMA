// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'dart:ffi';
import 'dart:io';

import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:Tanmeyah/Models/city_response.dart';
import 'package:Tanmeyah/Models/request_loan_response.dart';
import 'package:Tanmeyah/Models/submit_loan_response.dart';
import 'package:Tanmeyah/Network/city_api.dart';
import 'package:Tanmeyah/Network/request_loan_api.dart';
import 'package:Tanmeyah/Shared/shared_prefirences.dart';
import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';
import '../../../../Models/government_model.dart';
import '../../../../Models/governorates_response.dart';
import '../../../../Utilities/general_toast.dart';
import '../../../../Widgets/alert_for_location.dart';
import '../../../../Widgets/animated_alert.dart';
import '../../../../Widgets/location_alert.dart';
import '../loan_request_success/loan_request_success_screen.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permsion;
import 'package:firebase_analytics/firebase_analytics.dart';


import 'package:url_launcher/url_launcher.dart';

class LoanCityController extends ControllerMVC {
  // singleton
  factory LoanCityController() {
    _this ??= LoanCityController._();
    return _this!;
  }

  static LoanCityController? _this;

  LoanCityController._();

  bool loading = false,
      autoValidate = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  CityResponse? cityResponse;

  @override
  void initState() {
    super.initState();
    getGovernment();
  }

  @override
  void dispose() {
    selectedCityId = null;
    selectedGovernmentId = null;
    super.dispose();
  }

  String? selectedGovernmentId;
  String? governmentTitle;
  String? selectedCityId;
  String? cityTitle;
  List<BranchModel>? branchList;
  List<Governorates>? governoratesList;


  // String getSelectedGovernmentTitle() {
  //   final selectedItem = governmentsIds.firstWhere(
  //         (item) => item.id == selectedGovernment,
  //     orElse: () => GovernmentModel(id: '', title: ''), // ✅ Return an empty instance
  //   );
  //   return selectedItem.title.isNotEmpty ? selectedItem.title : "choose_gov".tr; // ✅ Default if empty
  // }

  Future getGovernment() async {
    loading = true;
    setState(() {
    });
    governoratesList = await CityApi.getGovernment();
    print("?????????????? Governorates List: ${governoratesList?.map((e) => e.toString()).join(', ') ?? 'null'}");
    print("?????????????? Total count: ${governoratesList?.length ?? 0}");
    loading = false;
    setState(() {
    });
  }


  Future getCityByGovernment({required String governmentId}) async {
    loading = true;
    setState(() {
    });
    cityResponse = await CityApi.getCityByGovernerate(governorateId: governmentId);
    branchList = cityResponse?.branches;
    loading = false;
    setState(() {
    });
  }

}


