import 'package:complete_story_view/controller/story_provider.dart';
import 'package:flutter/material.dart';

class StoryScope extends InheritedNotifier<StoryProvider> {
  const StoryScope({
    super.key,
    required StoryProvider super.notifier,
    required super.child,
  });

  static StoryProvider of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<StoryScope>();
    assert(scope != null, 'No StoryScope found in context');
    return scope!.notifier!;
  }
}
