import 'package:flutter/material.dart';

import '../Shared/shared_prefirences.dart';

enum Languages { ar, en }

class AppLanguage extends ChangeNotifier {
  Languages defaultLang = Languages.ar;

  Locale? _appLocale;
  Locale get appLocal => _appLocale ?? Locale(defaultLang.name);
  Languages get appLanguage => SharedPref.getCurrentLang() == null
      ? Languages
      .values[Languages.values.map((e) => e.name).toList().indexOf("ar")]
      : defaultLang;

  Locale fetchLocale() {
    if (SharedPref.getCurrentLang() != null) {
      _appLocale = Locale(SharedPref.getCurrentLang()!);
    } else {
      _appLocale = Locale(defaultLang.name);
    }
    return _appLocale!;
  }

  Future changeLanguage({required Languages lang}) async {
    if (_appLocale == Locale(lang.name)) return;
    _appLocale = Locale(lang.name);
    await SharedPref.setCurrentLang(lang: lang.name);
    notifyListeners();
  }
}
