import 'package:Tanmeyah/Utilities/helper.dart';

import '../../../Theme/app_assets.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: "onboarding1_title".tr,
      image: AppAssets.IMG_ONBOARDING_1,
      discription: "onboarding1_des".tr),
  UnbordingContent(
      title: "onboarding2_title".tr,
      image: AppAssets.IMG_ONBOARDING_2,
      discription: "onboarding2_des".tr),
  UnbordingContent(
      title: "onboarding3_title".tr,
      image: AppAssets.IMG_ONBOARDING_3,
      discription: "onboarding3_des".tr),
  UnbordingContent(
      title: "onboarding4_title".tr,
      image: AppAssets.IMG_ONBOARDING_4,
      discription: "onboarding4_des".tr),
  UnbordingContent(
      title: "onboarding5_title".tr,
      image: AppAssets.IMG_ONBOARDING_5,
      discription: "onboarding5_des".tr),
];
