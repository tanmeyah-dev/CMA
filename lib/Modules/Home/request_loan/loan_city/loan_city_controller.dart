// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides

import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:Tanmeyah/Models/city_response.dart';
import 'package:Tanmeyah/Network/city_api.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../../Models/governorates_response.dart';
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


