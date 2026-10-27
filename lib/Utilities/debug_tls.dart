import 'dart:io';

import 'qc_http_overrides.dart';

/// Debug-only. Release and profile compilation strip asserts, so this
/// certificate exception is not part of those programs.
void installDebugTlsOverride() {
  assert(() {
    HttpOverrides.global = QcHttpOverrides();
    return true;
  }());
}
