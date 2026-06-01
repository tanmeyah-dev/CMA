import 'dart:convert';

import 'package:enough_convert/enough_convert.dart';

const _windows1256 = Windows1256Codec();

/// Decodes an HTTP body when the server uses UTF-8 or Windows-1256 (common for Arabic APIs).
String decodeHttpBodyBytes(List<int> bytes, Map<String, String> headers) {
  if (bytes.isEmpty) return '';

  final contentType =
      headers['content-type'] ?? headers['Content-Type'] ?? '';
  final charset = RegExp(r'charset=([\w-]+)', caseSensitive: false)
          .firstMatch(contentType)
          ?.group(1)
          ?.toLowerCase() ??
      '';

  if (_isWindows1256Charset(charset)) {
    return _windows1256.decode(bytes);
  }

  try {
    return utf8.decode(bytes);
  } on FormatException {
    return _windows1256.decode(bytes);
  }
}

bool _isWindows1256Charset(String charset) {
  final normalized = charset.replaceAll('-', '').replaceAll('_', '');
  return normalized == 'windows1256' || normalized == 'cp1256';
}
