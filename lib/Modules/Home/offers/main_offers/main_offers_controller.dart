// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/offers_model.dart';
import 'package:Tanmeyah/Network/offers_api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class MainOffersController extends ControllerMVC {
  // singleton
  factory MainOffersController() {
    _this ??= MainOffersController._();
    return _this!;
  }

  static MainOffersController? _this;

  MainOffersController._();

  bool loading = false, autoValidate = false;

  OffersResponse? offersResponse;

  @override
  void initState() {
    getOffersList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future getOffersList() async {
    loading = true;
    setState(() {
    });
    offersResponse = await OffersApi.getOffers();
    loading = false;
    setState(() {
    });
  }


}
