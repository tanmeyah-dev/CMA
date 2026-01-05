import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceIdHelper {
  // Separate storage instance to isolate device ID from other secure storage operations
  static const _storage = FlutterSecureStorage();
  static const _keyDeviceId = "device_id";
  static const _uuid = Uuid();

  // Lock to prevent race conditions when generating device ID
  static Completer<String>? _pendingGeneration;

  /// Gets the device ID. If it doesn't exist, generates a new one and stores it.
  /// Returns the same ID on subsequent calls (persistent across app restarts).
  /// Thread-safe: prevents race conditions when multiple calls happen simultaneously.
  static Future<String> getDeviceId() async {
    // Try to get existing device ID
    String? existingId = await _storage.read(key: _keyDeviceId);

    if (existingId != null && existingId.isNotEmpty) {
      return existingId;
    }

    // If another call is already generating the ID, wait for it
    if (_pendingGeneration != null) {
      return await _pendingGeneration!.future;
    }

    // Create a completer for this generation
    _pendingGeneration = Completer<String>();

    try {
      // Double-check after acquiring lock (another call might have written it)
      existingId = await _storage.read(key: _keyDeviceId);
      if (existingId != null && existingId.isNotEmpty) {
        _pendingGeneration!.complete(existingId);
        _pendingGeneration = null;
        return existingId;
      }

      // Generate new UUID if it doesn't exist
      String newDeviceId = _uuid.v4();
      await _storage.write(key: _keyDeviceId, value: newDeviceId);

      // Verify it was written correctly
      String? verifyId = await _storage.read(key: _keyDeviceId);
      if (verifyId != null && verifyId.isNotEmpty) {
        _pendingGeneration!.complete(verifyId);
        _pendingGeneration = null;
        return verifyId;
      } else {
        throw Exception("Failed to store device ID");
      }
    } catch (e) {
      _pendingGeneration!.completeError(e);
      _pendingGeneration = null;
      rethrow;
    }
  }

  /// Gets the device ID synchronously (if already cached).
  /// Returns null if not yet generated.
  /// Use getDeviceId() for guaranteed result.
  static Future<String?> getDeviceIdIfExists() async {
    return await _storage.read(key: _keyDeviceId);
  }

  /// Resets the device ID (generates a new one).
  /// Use with caution - this will change the device identifier.
  static Future<String> resetDeviceId() async {
    String newDeviceId = _uuid.v4();
    await _storage.write(key: _keyDeviceId, value: newDeviceId);
    return newDeviceId;
  }

  /// Deletes the stored device ID.
  static Future<void> deleteDeviceId() async {
    await _storage.delete(key: _keyDeviceId);
  }

  /// Debug method: Gets current device ID and logs it
  /// Use this to verify the device ID is consistent
  static Future<String> getDeviceIdWithLog() async {
    String deviceId = await getDeviceId();
    print("🔍 Current Device ID: $deviceId");
    return deviceId;
  }
}
