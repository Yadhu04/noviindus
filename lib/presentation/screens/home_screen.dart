import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus/core/theme/app_colours.dart';

import 'package:noviindus/core/theme/app_text_style.dart';
import 'package:noviindus/presentation/providers/home_provider.dart';
import 'package:noviindus/presentation/screens/add_feed_screen.dart';
import 'package:noviindus/presentation/screens/my_feed_screen.dart';
// import 'package:noviindus/presentation/screens/my_feed_screen.dart';
import 'package:noviindus/presentation/widgets/video_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    /// load feeds
    Future.microtask(() {
      context.read<HomeProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
      ),
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

      // appBar: AppBar(title: Text('Home Screen')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                height: 30,
                child: ListView.separated(
                  itemCount: home.categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final category = home.categories[index];
                    return Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withAlpha(50)),
                      ),
                      child: Text(
                        category.name,
                        style: AppTextStyle.bodySecondary,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Container(height: 10.h, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ListView.separated(
              itemCount: home.feeds.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final feed = home.feeds[index];
                return VideoCard(feed: feed);
              },
              separatorBuilder: (context, index) =>
                  Container(height: 5.h, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
