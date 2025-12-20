import 'package:complete_story_view/controller/story_inherited_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:complete_story_view/controller/story_provider.dart';

import 'story_view.dart';

class StoryListWidget extends StatelessWidget {
  final List<StoryView> storyViewList;

  ///duration of the image story in miliseconds [dafault: 3000]
  final int? imageStoryDuration;

  ///calls when the last story gets finished
  final Function onComplete;
  const StoryListWidget({
    super.key,
    required this.storyViewList,
    this.imageStoryDuration,

    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return StoryScope(
      notifier: StoryProvider(lengthOfStoryPages: storyViewList.length)
        ..onInit(),
      child: _StoryListWidgetInitializer(
        storyViewList: storyViewList,
        imageStoryDuration: imageStoryDuration,
        onComplete: onComplete,
      ),
    );
  }
}

class _StoryListWidgetInitializer extends StatefulWidget {
  final List<StoryView> storyViewList;
  final int? imageStoryDuration;
  final Function onComplete;
  _StoryListWidgetInitializer({
    required this.storyViewList,
    this.imageStoryDuration,
    required this.onComplete,
  }) : assert(storyViewList.isNotEmpty, 'storyViewList list is empty'),
       assert(
         imageStoryDuration != null && imageStoryDuration >= 1000,
         'imageStoryDuration should be greater than 999',
       );

  @override
  State<_StoryListWidgetInitializer> createState() =>
      _StoryListWidgetInitializerState();
}

class _StoryListWidgetInitializerState
    extends State<_StoryListWidgetInitializer> {
  late StoryProvider storyProvider;

  @override
  void initState() {
    super.initState();
    // assert(
    //   widget.storyViewList.isNotEmpty,
    //   'storyViewList list must not be empty',
    // );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!StoryScope.of(context).isProviderInitialized) {
      storyProvider = StoryScope.of(context);
      storyProvider.setDefinedImageStoryDuration = widget.imageStoryDuration;
      storyProvider.isProviderInitialized = true;
      storyProvider.onComplete.addListener(() {
        widget.onComplete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: storyProvider.outerPageController,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: (int index) {},
      children: widget.storyViewList.map((storyPage) {
        return storyPage;
      }).toList(),
    );
  }
}
