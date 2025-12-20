import 'package:complete_story_view/story_package.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StoryListWidget(
        imageStoryDuration: 4000,
        onComplete: () {
          //
        },
        storyViewList: [
          StoryView(
            progressBarHeight: 8.0,
            storyChildren: [
              StoryWidget(url: "", storyType: StoryType.networkImage),
              StoryWidget(url: "", storyType: StoryType.networkImage),
            ],
          ),
          StoryView(
            progressBarHeight: 8.0,
            storyChildren: [
              StoryWidget(url: "", storyType: StoryType.networkVideo),
              StoryWidget(url: "", storyType: StoryType.networkImage),
              StoryWidget(url: "", storyType: StoryType.networkImage),
            ],
          ),
          StoryView(
            progressBarHeight: 8.0,
            storyChildren: [
              StoryWidget(url: "", storyType: StoryType.networkImage),
              StoryWidget(url: "", storyType: StoryType.networkImage),
            ],
          ),
        ],
      ),
    );
  }
}
