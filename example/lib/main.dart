import 'package:flutter/material.dart';
import 'package:story_package/story_package.dart';

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
      body: StoryView(
        storyChildren: [
          StoryWidget(
            url:
                "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          ),
          StoryWidget(url: "https://picsum.photos/id/237/536/354.jpg"),
          StoryWidget(
            url:
                "https://www.shutterstock.com/image-photo/demo-text-message-magnifying-glass-600nw-2491336635.jpg",
          ),
        ],
      ),
    );
  }
}
