import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freerasp/freerasp.dart';

/// True when a release build must stop because the device or the binary
/// failed a runtime check. Debug builds keep running so development is not
/// blocked by emulator, debugger, or USB debugging detections.
final ValueNotifier<bool> runtimeProtectionBlocked = ValueNotifier(false);

/// Starts freeRASP. Release mode enables the production checks and stops
/// the UI if the binary is hooked, repackaged, or running on a compromised
/// device. [watcherMail] receives Talsec's security report.
Future<void> startRuntimeProtection() async {
  if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
    return;
  }

  final config = TalsecConfig(
    androidConfig: AndroidConfig(
      packageName: 'com.tanmeyah.app',
      signingCertHashes: [
        // Local debug keystore.
        'DdVSSkUMC2/JLyEr2IJ38E7lg28B5MclVBzYuOTYwPM=',
        // android/tanmeyah-keystore.jks, alias tanmeyah.
        '4sT3YRVBV0DAz12RN4nwWt481eS95sk2zgJ59WVzGC0=',
      ],
      supportedStores: [],
    ),
    iosConfig: IOSConfig(
      bundleIds: ['com.tanmeyah.customerApp'],
      teamId: 'AKHF5NAD5X',
    ),
    watcherMail: 'info@tanmeyah.com',
    isProd: kReleaseMode,
    killOnBypass: kReleaseMode,
  );

  await Talsec.instance.attachListener(
    ThreatCallback(
      onAppIntegrity: () => _block('app integrity'),
      onHooks: () => _block('hooks'),
      onPrivilegedAccess: () => _block('privileged access'),
      onDebug: () => _block('debugger'),
      onSimulator: () => _block('simulator'),
      onUnofficialStore: () => _block('unofficial store'),
      onAutomation: () => _block('automation'),
      onBootloader: () => _block('bootloader'),
      onObfuscationIssues: () => _note('obfuscation'),
    ),
  );

  try {
    await Talsec.instance.start(config);
    if (kReleaseMode && Platform.isAndroid) {
      await Talsec.instance.blockScreenCapture(enabled: true);
    }
  } catch (error, stack) {
    debugPrint('Runtime protection failed to start: $error\n$stack');
    if (kReleaseMode) {
      runtimeProtectionBlocked.value = true;
    }
  }
}

void _block(String reason) {
  debugPrint('Runtime protection blocked the app: $reason');
  if (kReleaseMode) {
    runtimeProtectionBlocked.value = true;
  }
}

void _note(String reason) {
  debugPrint('Runtime protection notice: $reason');
}

/// Full-screen stop shown when a release build fails a runtime check.
class RuntimeProtectionBlock extends StatelessWidget {
  const RuntimeProtectionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF092076),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'لا يمكن تشغيل تنميه على هذا الجهاز لأن فحوصات الحماية لم تنجح.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Tanmeyah cannot run on this device because its security checks failed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
