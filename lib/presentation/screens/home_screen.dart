import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus/core/theme/app_colours.dart';

import 'package:noviindus/core/theme/app_text_style.dart';
import 'package:noviindus/presentation/screens/add_feed_screen.dart';
import 'package:noviindus/presentation/screens/my_feed_screen.dart';
import 'package:noviindus/presentation/widgets/video_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFeedScreen()),
          );
        },
        icon: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.buttonPrimary,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello Maria', style: AppTextStyle.smallHeading),
                      Text('Welcome back to Section', style: AppTextStyle.body),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyFeedScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/1200x/2e/a6/54/2ea65480fdfcc30d57e84cda93e2f30f.jpg',
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),
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
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
