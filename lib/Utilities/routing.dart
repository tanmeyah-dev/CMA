// ignore_for_file: depend_on_referenced_packages
import 'package:Tanmeyah/Modules/Account/account_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/AppVersion/app_version_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Conditions/conditions_screen.dart';
import 'package:Tanmeyah/Modules/Authentication/Register/registeration_error.dart';
import 'package:Tanmeyah/Modules/Billers/all_billers/all_billers_screen.dart';
import 'package:Tanmeyah/Modules/Billers/billers_services/billers_services_screen.dart';
import 'package:Tanmeyah/Modules/Home/request_loan/loan_request_amount/loan_request_amount_screen.dart';
import 'package:Tanmeyah/Modules/Home/request_loan/loan_request_out_of_cairo/loan_request_out_of_cairo_screen.dart';
import 'package:Tanmeyah/Modules/Home/request_loan/loan_request_terms/loan_request_terms_screen.dart';
import 'package:Tanmeyah/Modules/More/about_us/about_us_screen.dart';
import 'package:Tanmeyah/Modules/More/branches/branches_screen.dart';
import 'package:Tanmeyah/Modules/More/contact_us/contact_us_screen.dart';
import 'package:Tanmeyah/Modules/More/main_services/main_services_screen.dart';
import 'package:Tanmeyah/Modules/More/offer_detail/offer_details_screen.dart';
import 'package:Tanmeyah/Modules/More/services_detail/services_detail_screen.dart';
import 'package:Tanmeyah/Modules/loan/already_paid/already_paid_screen.dart';
import 'package:Tanmeyah/Modules/loan/main_loan/webview.dart';
import 'package:Tanmeyah/Modules/loan/payment_methods/payment_methods_screen.dart';
import 'package:Tanmeyah/Modules/loan/payment_needed/payment_needed_screen.dart';
import 'package:Tanmeyah/Utilities/no_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../Modules/Authentication/ForgetPassword/forget_password_screen.dart';
import '../Modules/Authentication/Login/local_auth/local_auth_screen.dart';
import '../Modules/Authentication/Login/login_screen.dart';
import '../Modules/Authentication/OTP/otp_screen.dart';
import '../Modules/Authentication/OnBoarding/onboarding_screen.dart';
import '../Modules/Authentication/Register/register_screen.dart';
import '../Modules/Authentication/Splash/splash_screen.dart';
import '../Modules/Authentication/Terms/terms_screen.dart';
import '../Modules/Authentication/ValidateUser/validate_user_screen.dart';
import '../Modules/Billers/get_bill_inquiry/get_bill_inquiry_screen.dart';
import '../Modules/Billers/mobile_billers/mobile_biller_screen.dart';
import '../Modules/Home/main_home/home_screen.dart';
import '../Modules/Home/offers/main_offers/main_offers_screen.dart';
import '../Modules/Home/request_loan/loan_request_success/loan_request_success_screen.dart';
import '../Modules/Main/main_screen.dart';
import '../Modules/More/main_more/more_screen.dart';
import '../Modules/loan/main_loan/main_loan_screen.dart';
import '../Modules/loan/previous_loans/previous_loan_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  final List<ModularRoute> routes = [
    defaultRoute(
        routeName: SplashScreen.routeName, child: const SplashScreen()),
    defaultRoute(
        routeName: AppVersionScreen.routeName, child: const AppVersionScreen()),
    defaultRoute(
        routeName: OnBoardingScreen.routeName, child: const OnBoardingScreen()),
    defaultRoute(
        routeName: ConditionsScreen.routeName, child: const ConditionsScreen()),
    defaultRoute(
        routeName: ValidateUserScreen.routeName,
        child: const ValidateUserScreen()),
    ChildRoute(RegistrationError.routeName,
        child: (_, args) => RegistrationError( phoneNumber: args.data,),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    defaultRoute(
        routeName: ForgetPasswordScreen.routeName,
        child: const ForgetPasswordScreen()),
    defaultRoute(routeName: TermsScreen.routeName, child: const TermsScreen()),
    defaultRoute(routeName: HomeScreen.routeName, child: const HomeScreen()),
    defaultRoute(routeName: PreviousLoanScreen.routeName, child: const PreviousLoanScreen()),
    defaultRoute(routeName: NoInternetScreen.routeName, child: const NoInternetScreen()),
    defaultRoute(
        routeName: MainLoanScreen.routeName, child: const MainLoanScreen()),
    defaultRoute(
        routeName: AccountScreen.routeName, child: const AccountScreen()),
    defaultRoute(routeName: MoreScreen.routeName, child: const MoreScreen()),
    defaultRoute(
        routeName: LoanRequestTermsScreen.routeName,
        child: const LoanRequestTermsScreen()),
    defaultRoute(
        routeName: LoanRequestAmountScreen.routeName,
        child: const LoanRequestAmountScreen()),
    defaultRoute(
        routeName: MainOffersScreen.routeName, child: const MainOffersScreen()),
    defaultRoute(
        routeName: MainServicesScreen.routeName,
        child: const MainServicesScreen()),
    defaultRoute(
        routeName: ContactUsScreen.routeName, child: const ContactUsScreen()),
    ChildRoute(AboutUsScreen.routeName,
        child: (_, args) => const AboutUsScreen(),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(PaymentMethodsScreen.routeName,
        child: (_, args) =>  PaymentMethodsScreen(amount: args.data,),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(LoanRequestOutOfCairoScreen.routeName,
        child: (_, args) => LoanRequestOutOfCairoScreen(branches: args.data,),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(AllBillersScreen.routeName,
        child: (_, args) => AllBillersScreen(serviceList: args.data,),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(MobileBillersScreen.routeName,
        child: (_, args) => MobileBillersScreen(title : args.data[0],billerId: args.data[1],),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(BillersServicesScreen.routeName,
        child: (_, args) => BillersServicesScreen(billers : args.data),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(GetBillInquiryScreen.routeName,
        child: (_, args) => GetBillInquiryScreen(billers : args.data[0],serviceName: args.data[1],),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    defaultRoute(
        routeName: BranchesScreen.routeName, child: const BranchesScreen()),
    ChildRoute(LoanSuccessRequestScreen.routeName,
        child: (_, args) => const LoanSuccessRequestScreen(),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(AlreadyPaidScreen.routeName,
        child: (_, args) => const AlreadyPaidScreen(),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(PaymentNeededScreen.routeName,
        child: (_, args) => const PaymentNeededScreen(),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(LoginScreen.routeName,
        child: (_, args) => LoginScreen(
              phoneNumber: args.data,
            ),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(MainScreen.routeName,
        child: (_, args) => MainScreen(
          index: args.data??0,
        ),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(OfferDetailScreen.routeName,
        child: (_, args) => OfferDetailScreen(
              offerID: args.data,
            ),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(LocalAuthScreen.routeName,
        child: (_, args) => const LocalAuthScreen(),
        transition: TransitionType.downToUp,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(ServicesDetailScreen.routeName,
        child: (_, args) => ServicesDetailScreen(
              serviceDetailModel: args.data,
            ),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(OtpScreen.routeName,
        child: (_, args) => OtpScreen(
              phoneNumber: args.data[0],
              onConfirm: args.data[1],
            ),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
    ChildRoute(RegisterScreen.routeName,
        child: (_, args) => RegisterScreen(
              phoneNumber: args.data,
            ),
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300)),
  ];

  static ChildRoute defaultRoute(
      {required String routeName, required Widget child}) {
    return ChildRoute(routeName,
        child: (_, args) => child,
        transition: TransitionType.fadeIn,
        duration: const Duration(milliseconds: 300));
  }
}
