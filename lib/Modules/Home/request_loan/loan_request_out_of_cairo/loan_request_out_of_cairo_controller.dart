import 'package:Tanmeyah/Models/request_loan_response.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class LoanRequestOutOfCairoController extends ControllerMVC {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get loading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  RequestLoanResponse? _response;
  RequestLoanResponse? get response => _response;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void setResponse(RequestLoanResponse? response) {
    _response = response;
    notifyListeners();
  }

  Future<void> submitLoanRequest({
    required String amount,
    required String city,
    required String address,
    required String phoneNumber,
  }) async {
    try {
      setLoading(true);
      setError(null);

      // TODO: Implement the actual API call
      // final response = await RequestLoanApi.submitLoanRequest(
      //   amount: amount,
      //   city: city,
      //   address: address,
      //   phoneNumber: phoneNumber,
      // );

      // setResponse(response);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
