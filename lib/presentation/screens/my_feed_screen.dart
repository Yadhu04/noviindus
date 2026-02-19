import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../core/theme/app_text_style.dart';
import '../providers/my_feed_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/video_card.dart';

class MyFeedScreen extends StatefulWidget {
  const MyFeedScreen({super.key});

  @override
  State<MyFeedScreen> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final token = context.read<AuthProvider>().token;
      if (token != null) {
        context.read<MyFeedProvider>().load(token);
      }
    });

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        final token = context.read<AuthProvider>().token;
        if (token != null) {
          context.read<MyFeedProvider>().load(token);
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyFeedProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
        title: Text('My Feed', style: AppTextStyle.smallHeading),
      ),
      body: ListView.builder(
        controller: controller,
        // padding: const EdgeInsets.all(16),
        itemCount: provider.feeds.length,
        itemBuilder: (context, index) {
          // / HEADER
          if (index == 0) {
            return SizedBox();
          }

          /// LOADING FOOTER
          if (index == provider.feeds.length + 1) {
            if (!provider.hasMore) return const SizedBox();

            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final feed = provider.feeds[index - 1];

          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: VideoCard(feed: feed),
          );
        },
      ),
    );
  }
}
