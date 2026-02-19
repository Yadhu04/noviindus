import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noviindus/core/theme/app_colours.dart';
import 'package:noviindus/core/theme/app_text_style.dart';
import 'package:noviindus/core/utils/time_ago.dart';
import 'package:noviindus/domain/entities/feed.dart';
import 'package:noviindus/presentation/providers/video_manager_provider.dart';
import 'package:noviindus/presentation/widgets/video_player_controls.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatelessWidget {
  final Feed feed;

  const VideoCard({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoManager = context.watch<VideoManagerProvider>();
    final isPlaying = videoManager.isPlaying(feed.id);
    final controller = videoManager.controller;

    return Container(
      color: AppColors.backgroundSecondary,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(feed.userImage),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feed.userName, style: AppTextStyle.title),
                    Text(
                      TimeAgo.format(feed.createdAt),
                      style: AppTextStyle.bodySecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),

          /// VIDEO AREA
          GestureDetector(
            onTap: () {
              context.read<VideoManagerProvider>().play(feed.id, feed.video);
            },
            child:
                isPlaying &&
                    controller != null &&
                    controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayerControls(controller: controller),
                  )
                : Image.network(
                    feed.thumbnail,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(feed.description, style: AppTextStyle.bodySecondary),
          ),
        ],
      ),
    );
  }
}
