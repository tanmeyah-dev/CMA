class API{


         static const String baseServerURL = "https://gateway.tanmeyah.com";
         static const String baseURL = "$baseServerURL/api/v1/";

  //=========================== api parameters ====================================
  static const String token = "Identity/Token";
  static const String validateUser = "Identity/SendOTP";
  static const String verifyOtp = "Identity/VerifyOTP";
  static const String deactivateUser = "Identity/DeactiveUser";
  static const String otpForgetPassword = "Identity/VerifyPhoneNumber";
  static const String login = "Identity/Login";
  static const String forgetPassword = "Identity/ForgotPassword";
  static const String resetPassword = "Identity/ResetPassword";
  static const String register = "Identity/Register";
  static const String terms = "TermsAndConditions/Terms";
  static const String conditions = "TermsAndConditions/Conditions";
  static const String home = "Identity/Home";
  static const String requestLoan = "Loan/RequestLoan";
  static const String getLoanDetails = "Loan/GetActiveLoan";
  static const String services = "Product";
  static const String servicesDetail = "Product/Details";
  static const String offer = "Offer";
  static const String offerDetail = "Offer/Details";
  static const String branches = "Branch/Branches";
  static const String paidInstallment = "Loan/paid-installments";
  static const String previousLoan = "Loan/GetHistoricalData";
  static const String dueInstallment = "Loan/due-Installment";
  static const String version = "Version";
  static const String checkVersion = "Version/checkversion";
  static const String contactUs = "identity/Contact";
}