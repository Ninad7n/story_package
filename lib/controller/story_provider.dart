import 'dart:developer';

import 'package:flutter/material.dart';

class StoryProvider extends ChangeNotifier {
  final int lengthOfStoryPages;
  StoryProvider({required this.lengthOfStoryPages});
  String storyPrefKey = "viewed_stories";
  bool pageNavi = false;
  bool isVideoMute = false;
  bool isDetailsLoading = false;
  int currentIndex = 0;
  int durationCurrentStory = 3000;
  PageController innerPageController = PageController();
  PageController outerPageController = PageController();

  updateCurrenIndex(value) {
    currentIndex = value;
    notifyListeners();
  }

  updateDuration(int? duartion) {
    durationCurrentStory = duartion ?? 3000;
    notifyListeners();
  }

  onPrevStory(childrenLength) {
    if (currentIndex == 0) {
      onFirstStoryTapped();
    } else {
      innerPageController.previousPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
    // durationCurrentStory = 0;
    notifyListeners();
  }

  onNextStory(childrenLength) {
    try {
      if (childrenLength == currentIndex + 1) {
        onStoryFinished();
      } else {
        innerPageController.nextPage(
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    } catch (e) {
      log('$e', name: 'ERROR AT onNextStory');
    }
    notifyListeners();
  }

  onStoryFinished() {
    log("$lengthOfStoryPages ${outerPageController.page}");
    if (lengthOfStoryPages != outerPageController.page! + 1) {
      outerPageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
      currentIndex = 0;
    }
    notifyListeners();
  }

  onFirstStoryTapped() {
    // updateDuration(0);
    currentIndex = 0;
    outerPageController.previousPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    notifyListeners();
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
