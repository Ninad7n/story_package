import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryVideoPlayer extends StatefulWidget {
  final String url;
  final Function(int? duration) call;
  final Widget? videoPlaceholder;
  const StoryVideoPlayer({
    super.key,
    required this.url,
    required this.call,
    this.videoPlaceholder,
  });

  @override
  State<StoryVideoPlayer> createState() => _StoryVideoPlayerState();
}

class _StoryVideoPlayerState extends State<StoryVideoPlayer> {
  VideoPlayerController? vController;

  @override
  void initState() {
    super.initState();
    // Get.find<StoriesController>().videoPauseStream = StreamController<void>();
    vController =
        VideoPlayerController.networkUrl(
            Uri.parse(widget.url),
            videoPlayerOptions: VideoPlayerOptions(),
          )
          ..initialize().then((_) {
            vController!.play();
            log("${vController!.value.duration.inMilliseconds}");
            widget.call(vController!.value.duration.inMilliseconds);
            setState(() {});
          });
    vController!.addListener(() {
      try {
        if (context.mounted) {
          if (ModalRoute.of(context)?.isCurrent ?? false) {
            vController!.play();
            vController!.setVolume(1);
          } else {
            vController!.pause();
            vController!.setVolume(0);
          }
        }
      } catch (e) {
        log('$e', name: 'ERROR AT vController!.addListener');
      }
    });
  }

  @override
  void dispose() {
    // Get.find<StoriesController>().videoPauseStream.close();
    vController!.removeListener(() {});
    vController!.pause();
    vController!.dispose(); //disposed in story details, outer PageView.builder
    log("dispose video");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return vController == null ||
            !vController!.value.isInitialized ||
            // ignore: unnecessary_null_comparison
            vController!.value.duration == null
        ? (widget.videoPlaceholder ??
              Center(child: CircularProgressIndicator(color: Colors.red)))
        : Stack(
            children: [
              // StreamBuilder(
              //   stream: Get.find<StoriesController>().videoPauseStream.stream,
              //   builder: (context, snap) {
              //     log("${snap.data}", name: "yuyuyy");
              //     if(snap.data != null && (snap.data as bool)) {
              //       vController!.pause();
              //     }else {
              //       vController!.play();
              //     }
              //     return VideoPlayer(vController!);
              //   },
              // ),
              VideoPlayer(vController!),
              // if (duration != null)
              //   LinearTimer(
              //     onTimerFinish: () {
              //       widget.call();
              //     },
              //     durationMiliseconds: duration!,
              //   ),
            ],
          );
  }
}
