import 'dart:io';

/// Accepts the internal QC host certificate used by TestFlight/QC builds.
/// Other hosts keep normal certificate validation.
class QcHttpOverrides extends HttpOverrides {
  static const String qcHost = 'dotnett-qc.tanmeyah.lan';

  static bool _isInternalHost(String host) {
    final normalized = host.toLowerCase();
    return normalized == qcHost || normalized.endsWith('.tanmeyah.lan');
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return _isInternalHost(host);
      };
  }
}
