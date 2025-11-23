import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:complete_story_view/controller/story_provider.dart';

import 'story_view.dart';

class StoryListWidget extends StatelessWidget {
  final List<StoryView> storyViewList;
  const StoryListWidget({super.key, required this.storyViewList});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoryProvider(lengthOfStoryPages: storyViewList.length),
      builder: (context, child) {
        return Consumer<StoryProvider>(
          builder: (context, state, child) {
            return PageView(
              controller: state.outerPageController,
              onPageChanged: (int index) {},
              children: storyViewList.map((storyPage) {
                return storyPage;
              }).toList(),
            );
          },
        );
      },
    );
  }
}
