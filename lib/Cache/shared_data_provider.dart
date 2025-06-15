import 'package:flutter/foundation.dart';

class SharedDataProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _appVersion = 0;

  int get appVersion => _appVersion;

  Future getData() async {
    await Future.delayed(const Duration(seconds: 3));
    _appVersion = 10;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('appVersion', appVersion));
  }
}
