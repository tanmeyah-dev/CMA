class API{


         // static const String baseServerURL = "https://gateway.tanmeyah.com";
          static const String JavaBaseServerURL = "https://192.168.51.201:8084";
         // static const String baseServerURL = "https://dotnett-qc.tanmeyah.lan:8102";
         static const String baseURL = "$JavaBaseServerURL/cma/api/";

  //=========================== api parameters ====================================
  static const String token = "auth/guest-token";
  static const String validateUser = "auth/otp/request";
  static const String verifyOtp = "auth/otp/verify";
  static const String deactivateUser = "Identity/DeactiveUser";
  static const String otpForgetPassword = "Identity/VerifyPhoneNumber";
  static const String login = "auth/login";
  static const String forgetPassword = "Identity/ForgotPassword";
  static const String resetPassword = "Identity/ResetPassword";
  static const String register = "auth/register";
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
  static const String contactApi = "Identity/Contact-Lookup";
}