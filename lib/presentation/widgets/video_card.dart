import 'package:flutter/material.dart';
import 'package:noviindus/core/theme/app_colours.dart';
import 'package:noviindus/core/theme/app_text_style.dart';

class VideoCard extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String timeAgo;
  final String description;

  const VideoCard({
    Key? key,
    required this.avatarUrl,
    required this.username,
    required this.timeAgo,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundSecondary,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username, style: AppTextStyle.title),
                  Text(timeAgo, style: AppTextStyle.bodySecondary),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(height: 450, color: Colors.yellow.shade200),
          SizedBox(height: 15),
          Text(description, style: AppTextStyle.bodySecondary),
        ],
      ),
    );
  }
}
