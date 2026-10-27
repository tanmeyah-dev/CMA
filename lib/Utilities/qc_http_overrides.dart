import 'dart:io';

/// Accepts the internal QC host certificate. Referenced only from an assert
/// in [installDebugTlsOverride], so release builds do not include it.
class QcHttpOverrides extends HttpOverrides {
  static const String qcHost = 'dotnett-qc.tanmeyah.lan';

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return host == qcHost;
      };
  }
}
