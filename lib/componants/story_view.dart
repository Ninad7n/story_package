import 'package:complete_story_view/controller/story_inherited_notifier.dart';
import 'package:complete_story_view/controller/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:complete_story_view/componants/story_widget.dart';

import '../widgets/linear_timer.dart';

class StoryView extends StatefulWidget {
  final List<StoryWidget> storyChildren;
  final double? progressBarHeight;
  final Color? barColor;
  final Color? progressCompletedColor;
  final Color? progressColor;
  StoryView({
    super.key,
    required this.storyChildren,

    ///height of the top progress bar of the story
    this.progressBarHeight,
    this.barColor,
    this.progressColor,
    this.progressCompletedColor,
  }) : assert(storyChildren.isNotEmpty, 'storyChildren list is empty');

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  late StoryProvider storyProvider;

  bool isDetailsLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      storyProvider = StoryScope.of(context);
      storyProvider.innerPageController = PageController(
        initialPage: storyProvider.currentIndex,
      );
      isDetailsLoading = false;
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    storyProvider.innerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isDetailsLoading
        ? SizedBox.shrink()
        : GestureDetector(
            onVerticalDragEnd: (value) {
              if (value.velocity.pixelsPerSecond.distance > 0 &&
                  value.velocity.pixelsPerSecond.dy > 0) {
                Navigator.pop(context);
              }
            },
            child: Stack(
              children: [
                // if (!state.isDetailsLoading)
                PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: storyProvider.innerPageController,
                  itemCount: widget.storyChildren.length,
                  onPageChanged: (value) {
                    // storyProvider.updateCurrenIndex(value);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return widget.storyChildren[index];
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 6),
                  child: Row(
                    children: widget.storyChildren.map((e) {
                      return storyProvider.currentIndex ==
                              widget.storyChildren.indexOf(e)
                          ? Expanded(
                              child: LinearTimer(
                                progressBarHeight: widget.progressBarHeight,
                                onTimerFinish: () {
                                  storyProvider.onNextStory(
                                    widget.storyChildren.length,
                                  );
                                },
                                durationMiliseconds:
                                    storyProvider.durationCurrentStory,
                              ),
                            )
                          : storyProvider.currentIndex >
                                widget.storyChildren.indexOf(e)
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Container(
                                  height: widget.progressBarHeight ?? 3,
                                  decoration: BoxDecoration(
                                    color:
                                        widget.progressCompletedColor ??
                                        Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Container(
                                  height: widget.progressBarHeight ?? 3,
                                  decoration: BoxDecoration(
                                    color: widget.barColor ?? Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            );
                    }).toList(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          storyProvider.onPrevStory(
                            widget.storyChildren.length,
                          );
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          storyProvider.onNextStory(
                            widget.storyChildren.length,
                          );
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
