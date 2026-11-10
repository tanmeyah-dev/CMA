import 'dart:io';

import 'qc_http_overrides.dart';

/// Accepts the internal QC host certificate for debug and TestFlight/release
/// builds that still point at `dotnett-qc.tanmeyah.lan`. Only that host is
/// exempted; other hosts keep normal TLS validation.
void installDebugTlsOverride() {
  HttpOverrides.global = QcHttpOverrides();
}
