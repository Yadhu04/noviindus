import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerControls({super.key, required this.controller});

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  bool showControls = true;

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;

    return GestureDetector(
      onTap: () => setState(() => showControls = !showControls),
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(c),

          /// PLAY PAUSE CENTER
          if (showControls)
            IconButton(
              iconSize: 60,
              color: Colors.white,
              icon: Icon(
                c.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
              ),
              onPressed: () {
                if (c.value.isPlaying) {
                  c.pause();
                } else {
                  c.play();
                }
                setState(() {});
              },
            ),

          /// BOTTOM BAR
          if (showControls)
            Positioned(bottom: 0, left: 0, right: 0, child: _bottomBar(c)),
        ],
      ),
    );
  }

  Widget _bottomBar(VideoPlayerController c) {
    final position = c.value.position;
    final duration = c.value.duration;

    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          /// TIME
          Text(
            _format(position),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),

          /// SEEK
          Expanded(
            child: Slider(
              value: position.inMilliseconds.toDouble().clamp(
                0,
                duration.inMilliseconds.toDouble(),
              ),
              max: duration.inMilliseconds.toDouble(),
              onChanged: (v) {
                c.seekTo(Duration(milliseconds: v.toInt()));
              },
            ),
          ),

          /// TOTAL
          Text(
            _format(duration),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}
