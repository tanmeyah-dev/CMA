// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides

import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:Tanmeyah/Models/city_response.dart';
import 'package:Tanmeyah/Network/city_api.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Models/government_model.dart';
// import 'package:location/location.dart';



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

  List<GovernmentModel> governmentsIds = [
    GovernmentModel(id: "1", title: 'القاهرة'),
    GovernmentModel(id: "2", title: 'الفيوم'),
    GovernmentModel(id: "61", title: 'كفر الشيخ'),
    GovernmentModel(id: "62", title: 'الاسكندرية'),
    GovernmentModel(id: "63", title: 'بني سويف'),
    GovernmentModel(id: "64", title: 'الغربية'),
    GovernmentModel(id: "65", title: 'الدقهلية'),
    GovernmentModel(id: "66", title: 'الشرقية'),
    GovernmentModel(id: "67", title: 'البحيرة'),
    GovernmentModel(id: "68", title: 'الوادي الجديد'),
    GovernmentModel(id: "69", title: 'البحر الاحمر'),
    GovernmentModel(id: "70", title: 'سوهاج'),
    GovernmentModel(id: "71", title: 'اسوان'),
    GovernmentModel(id: "72", title: 'اسيوط'),
    GovernmentModel(id: "73", title: 'قنا'),
    GovernmentModel(id: "74", title: 'المنيا'),
    GovernmentModel(id: "75", title: 'الجيزه'),
    GovernmentModel(id: "76", title: 'مرسي مطروح'),
    GovernmentModel(id: "79", title: 'دمياط'),
    GovernmentModel(id: "81", title: 'القليوبيه'),
    GovernmentModel(id: "101", title: 'المنوفيه'),
    GovernmentModel(id: "121", title: 'السويس'),
    GovernmentModel(id: "141", title: 'بورسعيد'),
    GovernmentModel(id: "161", title: 'الاسماعليه'),
    GovernmentModel(id: "162", title: 'الاقصر'),
  ];


  // String getSelectedGovernmentTitle() {
  //   final selectedItem = governmentsIds.firstWhere(
  //         (item) => item.id == selectedGovernment,
  //     orElse: () => GovernmentModel(id: '', title: ''), // ✅ Return an empty instance
  //   );
  //   return selectedItem.title.isNotEmpty ? selectedItem.title : "choose_gov".tr; // ✅ Default if empty
  // }

  Future getCityByGovernorat({required String governerateId}) async {
    loading = true;
    setState(() {
    });
    cityResponse = await CityApi.getCityByGovernerate(governorateId: governerateId);
    branchList = cityResponse?.branches;
    loading = false;
    setState(() {
    });
  }

}


