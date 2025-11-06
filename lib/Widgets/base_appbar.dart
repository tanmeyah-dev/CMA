// ignore_for_file: use_function_type_syntax_for_parameters, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:Tanmeyah/Utilities/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/themeclass.dart';
import 'package:iconsax/iconsax.dart';
class BaseAppBar extends PreferredSize {
  BaseAppBar.main(
      {String title = "",
      bool centerTitle = true,
      bool isBackButtonVisible = true,
      brightness = Brightness.light,
      Color backgroundColor = Colors.white,
      titleColor = const Color(0xffDB4B44),
      double elevation = 0.0,
      String hintText = "",
      searchChanged(String searchValue)?,
      searchSubmission(String searchValue)?,
      Function? onSearchClear,
      TextEditingController? searchController,
      bool enableSearch = false,
      bool enableSort = false,
      bool enableNotification = false,
      bool showTitleWithSearch = false,
      bool enableSearchEditing = true,
      bool enableClearSearch = false,
      BuildContext? context,
      List<Widget>? actions,
      Function? onFilterClicked,
      Function? navigateToSearch,
      void Function()? navigateToNotification})
      : super(
            preferredSize: Size.fromHeight(enableSearch
                ? showTitleWithSearch
                    ? 116.0
                    : 78
                : 56),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (!enableSearch)
                  AppBar(
                    titleSpacing: 0,
                    actions: (actions == null && enableNotification == true)
                        ? [
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Icon(
                                    Iconsax.notification,
                                    color: ThemeClass.fontColor,
                                  )),
                            ),
                          ]
                        : actions,
                    centerTitle: centerTitle,
                    backgroundColor: backgroundColor,
                    automaticallyImplyLeading: isBackButtonVisible,
                    leading: isBackButtonVisible
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context!);
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 8.w, top: 10.h),
                              child: BackButton(
                                color: titleColor ?? ThemeClass.primaryColor,
                              ),
                            ),
                          )
                        : Container(),
                    title: Text(
                      title,
                      maxLines: 1,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    elevation: elevation,
                  ),
                if (enableSearch)
                  Container(
                    color: backgroundColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (showTitleWithSearch)
                          AppBar(
                            centerTitle: centerTitle,
                            backgroundColor: backgroundColor,
                            title: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            elevation: elevation,
                          ),
                        Container(
                          margin: EdgeInsets.only(
                              top: showTitleWithSearch ? 0 : 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (!enableSearchEditing) {
                                        navigateToSearch!();
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        TextField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^[a-zA-Z ء-ي]+')),
                                          ],
                                          controller: searchController,
                                          decoration: InputDecoration(
                                            hintText: "search".tr,
                                            isDense: true,
                                            enabled: enableSearchEditing,
                                            prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 2),
                                                  // child: SvgPicture.asset(
                                                  //   AppAssets.IC_SEARCH,
                                                  //   width: 10,
                                                  //   height: 10,
                                                  // ),
                                                )),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 15),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                                color: ThemeClass.hintColor),
                                            filled: true,
                                            fillColor: ThemeClass.hintColor,
                                          ),
                                          style: TextStyle(
                                              color: ThemeClass.blackColor),
                                          onChanged: (value) {
                                            searchChanged!(value);
                                          },
                                          onSubmitted: (value) {
                                            searchSubmission!(value);
                                          },
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: enableClearSearch
                                              ? IconButton(
                                                  onPressed: () {
                                                    onSearchClear!();
                                                  },
                                                  icon: Icon(
                                                    Icons.clear,
                                                    color:
                                                        ThemeClass.primaryColor,
                                                  ),
                                                )
                                              : Container(
                                                  width: 1,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              (enableSort)
                                  ? GestureDetector(
                                      onTap: () {
                                        onFilterClicked!();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.w),
                                        margin: EdgeInsetsDirectional.only(
                                            end: 10.w),
                                        // decoration: BoxDecoration(
                                        //   color: AppColors.gray.withOpacity(.2),
                                        //   borderRadius: BorderRadius.circular(10),
                                        // ),
                                        // child: SvgPicture.asset(
                                        //   AppAssets.IC_FILTER,
                                        //   height: 19,
                                        //   width: 23,
                                        // )),
                                      ))
                                  : Container(),
                              (enableNotification)
                                  ? GestureDetector(
                                      onTap: navigateToNotification,
                                      child: Container(
                                        padding: EdgeInsetsDirectional.only(
                                            end: 5.w),
                                        margin: EdgeInsetsDirectional.only(
                                            end: 10.w),
                                        // child: Image.asset(
                                        //   AppAssets.IC_NOTIFICATION,
                                        //   height: 23,
                                        //   width: 23,
                                        // )
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
              ],
            ));
}
