import 'package:flutter/material.dart';

class StoryProvider extends ChangeNotifier {
  final int lengthOfStoryPages;
  StoryProvider({required this.lengthOfStoryPages}) {
    onInit();
  }
  bool pageNavi = false;
  bool isVideoMute = false;
  bool isProviderInitialized = false;
  int currentIndex = 0;
  int durationCurrentStory = 3000;
  int _definedImageStoryDuration = 3000;
  PageController innerPageController = PageController();
  PageController outerPageController = PageController();
  ValueNotifier<bool> onComplete = ValueNotifier(false);

  onInit() {
    onComplete.value = false;
  }

  get getDefinedImageStoryDuration => _definedImageStoryDuration;

  set setDefinedImageStoryDuration(int? value) =>
      _definedImageStoryDuration = value ?? 3000;

  // updateCurrenIndex(value) {
  //   // currentIndex = value;
  //   // notifyListeners();
  // }

  // onOuterPapeChanges() {
  //   currentIndex = outerPageController.page!.toInt();
  //   notifyListeners();
  // }

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
      currentIndex--;
    }
    // durationCurrentStory = 0;
    notifyListeners();
  }

  onNextStory(childrenLength) {
    if (childrenLength == currentIndex + 1) {
      onStoryFinished();
    } else {
      innerPageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
      currentIndex++;
    }

    notifyListeners();
  }

  onStoryFinished() {
    if (lengthOfStoryPages != outerPageController.page! + 1) {
      outerPageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
      currentIndex = 0;
    } else {
      onComplete.value = true;
      // Navigator.pop(context);
    }
    notifyListeners();
  }

  onFirstStoryTapped() {
    // updateDuration(0);

    outerPageController.previousPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    );
    currentIndex = outerPageController.page!.toInt();
    notifyListeners();
  }

  int getDuration(tag) {
    if (tag == "img") {
      return 3000;
    } else {
      return 100000;
    }
  }
}
