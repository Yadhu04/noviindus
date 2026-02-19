import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus/core/theme/app_colours.dart';
import 'package:noviindus/core/theme/app_text_style.dart';
import 'package:noviindus/presentation/widgets/categories_section.dart';

class AddFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  Text('Add Feeds', style: AppTextStyle.smallHeading),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(10, 32.h),
                      side: BorderSide(
                        color: AppColors.buttonPrimary,
                        width: 0.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Share Post",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(15),
                  dashPattern: [12, 10],

                  strokeWidth: 2,
                  color: Colors.white.withAlpha(50),
                ),
                child: Container(
                  height: 270.h,
                  width: double.infinity,
                  color: AppColors.backgroundSecondary,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/upload.png',
                          width: 48,
                          height: 48,
                          color: Colors.white.withAlpha(150),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Select a video from Gallery',
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(15),
                  dashPattern: [12, 10],

                  strokeWidth: 2,
                  color: Colors.white.withAlpha(50),
                ),
                child: Container(
                  height: 130.h,
                  width: double.infinity,
                  color: AppColors.backgroundSecondary,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/image.png',
                          width: 48,
                          height: 48,
                          color: Colors.white.withAlpha(150),
                        ),
                        SizedBox(width: 50.w),

                        Text(
                          'Add a Thumbnail',
                          style: TextStyle(
                            color: Colors.white.withAlpha(150),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text('Add Description', style: AppTextStyle.title),
              SizedBox(height: 12.h),
              SizedBox(
                height: 80.h,
                child: TextField(
                  maxLines: null, // allows multiline
                  expands: true, // fills the height
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white.withAlpha(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white.withAlpha(50)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white.withAlpha(50)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Text('Categories This Project', style: AppTextStyle.title),
              CategoriesSelector(),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
