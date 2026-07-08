// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides

import 'package:Tanmeyah/Models/branches_model.dart';
import 'package:Tanmeyah/Network/branch_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../Shared/shared_prefirences.dart';



class BranchesController extends ControllerMVC {
  // singleton
  factory BranchesController() {
    _this ??= BranchesController._();
    return _this!;
  }

  static BranchesController? _this;

  BranchesController._();

  bool loading = false, autoValidate = false;
  late TextEditingController searchController;

  List<BranchModel> branchList = [];

  RefreshController? refreshController;

  String? currentLatitude;
  String? currentLongitude;

  int pageNumber = 1;

  @override
  void initState() {
    searchController = TextEditingController();
    refreshController = RefreshController(initialRefresh: false);
    getAllBranches();
    super.initState();
  }

  @override
  void dispose() {
    refreshController?.dispose();
    searchController.dispose();
    pageNumber = 1;
    super.dispose();
  }


  Future getAllBranches() async {
    String? userLatitude =  SharedPref.getUserLatitude();
    String? userLongitude =  SharedPref.getUserLongitude();

    currentLatitude = userLatitude;
    currentLongitude = userLongitude;
    setState(() {});

    loading = true;
    setState(() {});
    branchList = await BranchApi.getBranches(pageNumber: pageNumber.toString(),branchName: searchController.text,latitude: currentLatitude,longitude: currentLongitude);
    loading = false;
    setState(() {});
  }


  Future onRefresh() async {
    pageNumber = 1;
    await getAllBranches();
    refreshController?.loadComplete();
    refreshController?.refreshCompleted();
  }

  void onLoading() async {
    List<BranchModel> paginatedBranchList = [];
    pageNumber += 1;
    paginatedBranchList = await BranchApi.getBranches(pageNumber: pageNumber.toString(),branchName: searchController.text,latitude: currentLatitude,longitude: currentLongitude);
     branchList.addAll(paginatedBranchList);
      refreshController?.loadComplete();
    refreshController?.refreshCompleted();
    setState(() { });
  }


}
