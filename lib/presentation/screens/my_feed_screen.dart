import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:noviindus/core/theme/app_text_style.dart';
import 'package:noviindus/presentation/widgets/video_card.dart';

class MyFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(title: Text('Home Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
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
                  SizedBox(width: 8.w),
                  Text('My Feed', style: AppTextStyle.smallHeading),
                ],
              ),

              // SizedBox(height: 10.h),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => VideoCard(
                  avatarUrl:
                      'https://i.pinimg.com/1200x/2e/a6/54/2ea65480fdfcc30d57e84cda93e2f30f.jpg',
                  username: 'Maria',
                  timeAgo: '2 hours ago',
                  description:
                      'Lorem ipsum dolor sit amet consectetur. Leo ac lorem faucli bus facilisis tellus. At vitae dis commodo nunc sollicitudin elementum suspendisse...',
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
