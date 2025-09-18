import 'package:flutter/material.dart';

class StoryProvider extends ChangeNotifier {
  String storyPrefKey = "viewed_stories";
  bool pageNavi = false;
  bool isVideoMute = false;
  bool isDetailsLoading = false;
  int currentIndex = 0;
  int durationCurrentStory = 0;
  int currentProductScrollIndex = 0;
  PageController innerPageController = PageController();
  List<String> viewedData = [];
  // VideoPlayerController? vController;

  updateCurrenIndex(value) {
    currentIndex = value;
    notifyListeners();
  }

  updateDuration(int? duartion) {
    durationCurrentStory = duartion ?? 30000;
    notifyListeners();
  }

  onPrevStory() {
    if (currentIndex == 0) {
      innerPageController.previousPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    } else {
      innerPageController.previousPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
    durationCurrentStory = 0;
    notifyListeners();
  }

  onNextStory(childrenLength) {
    if (childrenLength == (currentIndex + 1)) {
      innerPageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    } else {
      innerPageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
    durationCurrentStory = 0;
    notifyListeners();
  }

  onStoryFinished() {
    //check is last story
    /* if (widget.storyChildren.indexOf(e) ==
        widget.storyChildren.length - 1) {
      if (ModalRoute.of(context)?.isCurrent ??
          false)
        Navigator.pop(context);
    } */
    innerPageController.nextPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    durationCurrentStory = 0;
  }

  int getDuration(tag) {
    if (tag == "img") {
      // if(storyDetails[currentIndex].products.isNotEmpty) {
      //   return 8000;
      // }
      return 3000;
    } else {
      return 100000;
    }
  }
}
