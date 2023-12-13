import 'package:flutter/material.dart';

import '../Theme/themeclass.dart';

// ignore: non_constant_identifier_names
AnimatedAlertDialog(BuildContext context, Widget widget) async {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
     // barrierColor: Colors.black.withOpacity(0.9),
    transitionDuration: const Duration(milliseconds: 700),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return widget;
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: <Color>[ ThemeClass.blackColor.withOpacity(0.6) , ThemeClass.blackColor.withOpacity(0.3)]),
        ),
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        ),
      );
    },
  );
}
