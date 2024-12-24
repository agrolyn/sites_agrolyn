import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Membuat controller Youtube dengan ID video dari URL
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true, // Menentukan apakah video langsung diputar
        mute: false, // Tidak di-mute
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Jangan lupa untuk dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            player,
            // Kamu bisa menambahkan widget lain di sini
          ],
        );
      },
    );
  }
}

// Fungsi untuk menampilkan popup dengan video player
void showVideoDialog(BuildContext context, String videoUrl) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: VideoPlayerScreen(videoUrl: videoUrl),
      );
    },
  );
}
