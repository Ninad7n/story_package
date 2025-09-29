import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_package/componants/story_widget.dart';
import 'package:story_package/controller/story_provider.dart';

import '../widgets/linear_timer.dart';

class StoryView extends StatefulWidget {
  final List<StoryWidget> storyChildren;
  final double? progressBarHeight;
  final Color? barColor;
  final Color? barColorCompleted;
  final Color? progressColor;
  const StoryView({
    super.key,
    required this.storyChildren,
    this.progressBarHeight,
    this.barColor,
    this.progressColor,
    this.barColorCompleted,
  });

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoryProvider(),
      builder: (context, child) {
        return Consumer<StoryProvider>(
          builder: (context, state, child) {
            return GestureDetector(
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
                    controller: state.innerPageController,
                    itemCount: widget.storyChildren.length,
                    onPageChanged: (value) {
                      state.updateCurrenIndex(value);
                      // if (widget.storyChildren.length == value + 1) {
                      //   log("LAST STORY");
                      // }
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return widget.storyChildren[index];
                    },
                  ),
                  if (!state.isDetailsLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 6),
                      child: Row(
                        children: widget.storyChildren.map((e) {
                          return state.currentIndex ==
                                  widget.storyChildren.indexOf(e)
                              ? Expanded(
                                  child: LinearTimer(
                                    progressBarHeight: widget.progressBarHeight,
                                    onTimerFinish: () {
                                      state.onNextStory(
                                        widget.storyChildren.length,
                                      );
                                    },
                                    durationMiliseconds:
                                        state.durationCurrentStory,
                                  ),
                                )
                              : state.currentIndex >
                                    widget.storyChildren.indexOf(e)
                              ? Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Container(
                                      height: widget.progressBarHeight ?? 3,
                                      decoration: BoxDecoration(
                                        color:
                                            widget.barColorCompleted ??
                                            Colors.white60,
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
                  if (!state.isDetailsLoading)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              state.onPrevStory();
                            },
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              state.onNextStory(widget.storyChildren.length);
                            },
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (state.isDetailsLoading && state.pageNavi)
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  if (state.isDetailsLoading)
                    Center(
                      child: CircularProgressIndicator(color: Colors.white54),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
