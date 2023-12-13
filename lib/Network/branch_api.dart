import 'package:Tanmeyah/Models/branches_model.dart';
import 'api.dart';
import 'network_methods.dart';

class BranchApi {
  static Future<List<BranchModel>> getBranches({String? pageNumber , String? branchName,String? latitude,String? longitude}) async {
    var response = await NetworkMethods.postRequestAsRow(
        url: API.branches,
        body: {"pageNumber": pageNumber , "pageSize": 15, "branchName": branchName??"","longitude" : longitude??0,"latitude" : latitude??0});
    if (response == null) return [];
    if (response["isSuccess"] == true) {
      final result = response["branches"];
      return List.from(result.map((e) => BranchModel.fromJson(e)));
    } else {
      return [];
    }
  }
}


