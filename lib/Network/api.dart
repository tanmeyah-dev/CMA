class API{


           static const String baseServerURL = "https://gateway.tanmeyah.com:8443";
          // static const String baseServerURL = "https://dev.tanmeyah.lan:8090";
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
  static const String branches = "Location/Branches";
  static const String paidInstallment = "Loan/paid-installments";
  static const String previousLoan = "Loan/GetHistoricalData";
  static const String dueInstallment = "Loan/due-Installment";
  static const String version = "Version";
  static const String checkVersion = "Version/checkversion";
  static const String contactUs = "identity/Contact";
  ///////////// 
  static const String getBillers = "BillPayment/get-billers?ServiceTypeId=";
  static const String getBillerServices = "BillPayment/services/";
  static const String getBillInquiry = "BillPayment/get-bill-inquiry";
  static const String excuteDailyJob = "BillPayment/execute-daily-job";
  static const String getServiceType = "BillPayment/get-service-types";
  static const String getGovernorates = "Location/Governorates";
  static const String getCites = "Location/Governorates";
  static const String getBranchWithCites = "Location/BranchesByGovernorateId";
  static const String getLoanProducts = "Product/LoanRequestProducts";
  static const String getFAQ = "FAQ";
}