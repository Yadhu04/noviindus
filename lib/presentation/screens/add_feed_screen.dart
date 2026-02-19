import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_colours.dart';
import '../../core/theme/app_text_style.dart';
import '../providers/auth_provider.dart';
import '../providers/upload_provider.dart';
import '../widgets/categories_section.dart';

class AddFeedScreen extends StatelessWidget {
  const AddFeedScreen({super.key});

  void _submit(BuildContext context) async {
    final upload = context.read<UploadProvider>();
    final token = context.read<AuthProvider>().token;

    if (token == null) return;

    try {
      await upload.submit(token);

      if (!context.mounted) return;
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final upload = context.watch<UploadProvider>();

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
        title: Row(
          children: [
            Text('Add Feeds', style: AppTextStyle.smallHeading),
            const Spacer(),
            ElevatedButton(
              onPressed: upload.uploading ? null : () => _submit(context),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(10, 32.h),
                side: const BorderSide(
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
      ),
      body: Stack(
        children: [
          /// MAIN CONTENT
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                // SizedBox(height: 60.h),

                /// HEADER
                // SizedBox(height: 40.h),

                /// VIDEO PICK
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(15),
                    dashPattern: const [12, 10],
                    strokeWidth: 2,
                    color: Colors.white.withAlpha(50),
                  ),
                  child: GestureDetector(
                    onTap: upload.pickVideo,
                    child: Container(
                      height: 270.h,
                      color: AppColors.backgroundSecondary,
                      child: upload.video == null
                          ? _videoPlaceholder()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio:
                                    upload.previewController!.value.aspectRatio,
                                child: VideoPlayer(upload.previewController!),
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                /// IMAGE PICK
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(15),
                    dashPattern: const [12, 10],
                    strokeWidth: 2,
                    color: Colors.white.withAlpha(50),
                  ),
                  child: GestureDetector(
                    onTap: upload.pickImage,
                    child: Container(
                      height: 130.h,
                      color: AppColors.backgroundSecondary,
                      child: upload.image == null
                          ? _imagePlaceholder()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                upload.image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                /// DESCRIPTION
                Text('Add Description', style: AppTextStyle.title),
                SizedBox(height: 12.h),

                SizedBox(
                  height: 80.h,
                  child: TextField(
                    onChanged: upload.setDescription,
                    expands: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                /// CATEGORIES
                const CategoriesSelector(),

                SizedBox(height: 12.h),
              ],
            ),
          ),

          if (upload.uploading) _UploadOverlay(upload.progress),
        ],
      ),
    );
  }
}

//PLACEHOLDERS

Widget _videoPlaceholder() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/upload.png',
          width: 48,
          height: 48,
          color: Colors.white.withAlpha(150),
        ),
        const SizedBox(height: 12),
        Text(
          'Select a video from Gallery',
          style: TextStyle(color: Colors.white.withAlpha(200)),
        ),
      ],
    ),
  );
}

Widget _imagePlaceholder() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/image.png',
          width: 48,
          height: 48,
          color: Colors.white.withAlpha(150),
        ),
        const SizedBox(width: 50),
        Text(
          'Add a Thumbnail',
          style: TextStyle(color: Colors.white.withAlpha(150)),
        ),
      ],
    ),
  );
}

///OVERLAY
class _UploadOverlay extends StatelessWidget {
  final double progress;

  const _UploadOverlay(this.progress);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(value: progress),
                ),
                const SizedBox(height: 16),
                Text(
                  "${(progress * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Uploading...",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
