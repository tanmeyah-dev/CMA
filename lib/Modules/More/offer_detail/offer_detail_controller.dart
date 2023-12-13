// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unnecessary_overrides
import 'package:Tanmeyah/Models/offers_model.dart';
import 'package:Tanmeyah/Network/offers_api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class OfferDetailController extends ControllerMVC {
  // singleton
  factory OfferDetailController() {
    _this ??= OfferDetailController._();
    return _this!;
  }

  static OfferDetailController? _this;

  OfferDetailController._();

  bool loading = false, autoValidate = false;

  int? offerId;
  OfferModel? offerModel;

  @override
  void initState() {
    getOfferDetail();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getOfferDetail() async {
    loading = true;
    setState(() {
    });
    offerModel = await OffersApi.getOfferDetail(offerId : offerId.toString());
    loading = false;
    setState(() {
    });
  }


}
