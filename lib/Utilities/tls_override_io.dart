import 'dart:io';

import 'qc_http_overrides.dart';

/// Accepts the internal QC host certificate. Only that host is exempted.
void installDebugTlsOverride() {
  HttpOverrides.global = QcHttpOverrides();
}
