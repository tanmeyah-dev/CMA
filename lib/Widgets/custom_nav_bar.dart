
// ignore_for_file: use_key_in_widget_constructors, unnecessary_import, prefer_if_null_operators, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/themeclass.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget(
      {Key? key,
        required this.selectedIndex,
        required this.items,
        required this.onItemSelected,});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ThemeClass.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: isSelected ? 24.sp : 30.sp,
                  color: isSelected ? ThemeClass.whiteColor : ThemeClass.hintColor.withOpacity(0.6)
              ),
              child: item.icon,
            ),
          ),
          isSelected ?  Material(
            type: MaterialType.transparency,
            child: FittedBox(
                child: Text(
                  item.title??"",
                  style: TextStyle(
                      color: ThemeClass.whiteColor,
                      fontSize: 16.sp),
                )),
          ) : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ThemeClass.yellowColor,
        borderRadius: BorderRadius.circular(60.sp)
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(
                    item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
