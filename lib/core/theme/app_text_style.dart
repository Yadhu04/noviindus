import 'package:flutter/material.dart';
import 'package:noviindus/core/theme/app_colours.dart';

import 'app_text_size.dart';

class AppTextStyle {

    static TextStyle heading = TextStyle(
    fontSize: AppTextSize.heading,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

    static TextStyle smallHeading = TextStyle(
    fontSize: AppTextSize.headingsmall,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

    static TextStyle title = TextStyle(
    fontSize: AppTextSize.title,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );


  static TextStyle body = TextStyle(
    fontSize: AppTextSize.md,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySecondary = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: AppTextSize.sm,
    color: AppColors.textSecondary,
  );




  // static TextStyle button = TextStyle(
  //   fontSize: AppTextSize.lg,
  //   fontWeight: FontWeight.w600,
  //   color: AppColors.textPrimary,
  // );
}
