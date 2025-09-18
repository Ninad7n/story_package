import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_package/controller/story_provider.dart';
import 'package:story_package/widgets/video_player.dart';

class StoryWidget extends StatelessWidget {
  final String url;
  // final Function(int? duration) callback;
  const StoryWidget({
    super.key,
    required this.url /* required this.callback */,
  });

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
  Widget build(BuildContext context) {
    return isImageUrl(url)
        ? CachedNetworkImage(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            imageUrl: url,
            fit: BoxFit.cover,
          )
        : isVideoUrl(url)
        ? StoryVideoPlayer(
            url: url,
            call: (duration) {
              // callback(duration);
              Provider.of<StoryProvider>(context).updateDuration(duration);
            },
          )
        : SizedBox.shrink();
  }
}
