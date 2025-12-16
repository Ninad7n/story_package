import 'package:complete_story_view/controller/story_provider.dart';
import 'package:complete_story_view/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///set type of your story i.e image or video
enum StoryType { networkImage, networkVideo } //assetImage, assetVideo

class StoryWidget extends StatefulWidget {
  final String url;
  final Widget? videoPlaceholder;
  final StoryType? storyType;
  final BoxFit? imageFit;

  // final Function(int? duration) callback;
  const StoryWidget({
    super.key,
    required this.url,
    this.videoPlaceholder,
    this.storyType,
    this.imageFit,
  });

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  bool isImageUrl(String url) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'svg'];
    final ext = url.split('.').last.toLowerCase();
    return imageExtensions.contains(ext);
  }

  bool isVideoUrl(String url) {
    final videoExtensions = ['mp4', 'mov', 'wmv', 'flv', 'avi', 'mkv', 'webm'];
    final ext = url.split('.').last.toLowerCase();
    return videoExtensions.contains(ext);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isImageUrl(widget.url)) {
        context.read<StoryProvider>().updateDuration(3000);
      } else if (isVideoUrl(widget.url)) {
        context.read<StoryProvider>().updateDuration(30000);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.storyType == StoryType.networkImage || isImageUrl(widget.url)
        ? Image(
            image: NetworkImage(widget.url),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: widget.imageFit ?? BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error, size: 40));
            },
          )
        : widget.storyType == StoryType.networkVideo || isVideoUrl(widget.url)
        ? StoryVideoPlayer(
            url: widget.url,
            call: (duration) {
              // callback(duration);
              context.read<StoryProvider>().updateDuration(duration);
            },
          )
        : Image(
            image: NetworkImage(widget.url),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: widget.imageFit ?? BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error, size: 40));
            },
          );
  }
}
