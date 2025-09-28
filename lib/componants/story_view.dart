import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_package/componants/story_widget.dart';
import 'package:story_package/controller/story_provider.dart';

import '../widgets/linear_timer.dart';

class StoryView extends StatefulWidget {
  final List<StoryWidget> storyChildren;
  const StoryView({super.key, required this.storyChildren});

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
                      //   // Get.find<StoriesController>().setViewedStories(widget.id);
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
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Container(
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
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
                  // if(!state.isDetailsLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            // gradient: LinearGradient(
                            //   begin: Alignment.bottomCenter,
                            //   end: Alignment.topCenter,
                            //   colors: [
                            //     Color(0xffF9CE34),
                            //     Color(0xffEE2A7B),
                            //     Color(0xff6228D7),
                            //   ],
                            // ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            /* child: ClipRRect(
                              borderRadius: BorderRadius.circular(400),
                              child: CachedNetworkImage(
                                height: 45,
                                width: 45,
                                imageUrl: "",
                                fit: BoxFit.cover,
                              ),
                            ), */
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "title",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        /* GetBuilder<StoriesController>(builder: (state) {
                          return widget.storyChildren.isNotEmpty &&
                                  widget.storyChildren[state.currentIndex].tag != "img"
                              ? IconButton(
                                  onPressed: () {
                                    // state.manageVideoVolume();
                                  },
                                  icon: Icon(
                                    state.isVideoMute
                                        ? Icons.volume_off_rounded
                                        : Icons.volume_up_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              : SizedBox.shrink();
                        }), */
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.clear, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  /* 
                  shop me widget
                  */
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
