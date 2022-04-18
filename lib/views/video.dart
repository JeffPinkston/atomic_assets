import 'package:atomic_assets/provider/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class Video extends StatefulWidget {
  Video();

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _videoPlayerController;
  String endpoint = 'https://ipfs.io/ipfs/';
  bool isVideoInitialized = false;
  bool isPlaying = false;

  void loadVideo(BuildContext context) {
    _videoPlayerController = VideoPlayerController.network(
        endpoint + context.watch<VideosProvider>().selectedVideo)
      ..initialize().then((_) {
        setState(() {
          isVideoInitialized = true;
          isPlaying = true;
        });
        _videoPlayerController.play();
      }).then((_) {
        _videoPlayerController.addListener(() {
          if (_videoPlayerController.value.position ==
              _videoPlayerController.value.duration) {
            // Call next song when current has ended
            context.read<VideosProvider>().next();
            setState(() {
              isVideoInitialized = false;
            });
          }
        });
      });
  }

  void playPausePressed() {
    if (isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void backPressed() {
    _videoPlayerController.pause();
    context.read<VideosProvider>().back();
    setState(() {
      isVideoInitialized = false;
    });
  }

  void nextPressed() {
    _videoPlayerController.pause();
    context.read<VideosProvider>().next();
    setState(() {
      isVideoInitialized = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isVideoInitialized) loadVideo(context);

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          !_videoPlayerController.value.isInitialized
              ? const Spacer()
              : Container(),
          _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
              : const CircularProgressIndicator(
                  strokeWidth: 5,
                ),
          _videoPlayerController.value.isInitialized
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed:
                            context.watch<VideosProvider>().selectedIndex > 0
                                ? backPressed
                                : null,
                        icon: const Icon(Icons.arrow_back)),
                    IconButton(
                        onPressed: playPausePressed,
                        icon: isPlaying
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow)),
                    IconButton(
                        onPressed: context
                                    .watch<VideosProvider>()
                                    .selectedIndex <
                                context.watch<VideosProvider>().videos.length -
                                    1
                            ? nextPressed
                            : null,
                        icon: const Icon(Icons.arrow_forward))
                  ],
                )
              : Container(),
          _videoPlayerController.value.isInitialized
              ? Text(context.watch<VideosProvider>().selectedName)
              : const Spacer(),
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}
