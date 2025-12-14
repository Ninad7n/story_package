# complete story view for Flutter

A lightweight and customizable Flutter package for creating Instagram‑like story views. This package provides widgets to display multiple stories with built‑in progress bars, automatic transitions, and support for images and videos.

---
<img width="150" height="320" alt="Screenshot_1765699096" src="https://github.com/user-attachments/assets/bb838001-38d2-4f5b-a78d-79b460ddc682" />
<img width="150" height="320" alt="Screenshot_1765699040" src="https://github.com/user-attachments/assets/cc344db9-2275-43e4-bae5-f61d37ee70c7" />
<img width="150" height="320" alt="Screenshot_1765699055" src="https://github.com/user-attachments/assets/3752d11c-93f1-4476-a3cd-ea84257b0537" />

## ✨ Features

* Display a list of story groups
* Each group contains multiple story items
* Supports image URLs (video support can be added similarly)
* Built‑in progress indicator for each story
* Fully customizable UI components

---

## 🚀 Usage

Import the package:

```dart
import 'package:complete_story_view/story_package.dart';
```

Use the `StoryListWidget` to display multiple story groups:

```dart
StoryListWidget(
  storyViewList: [
    StoryView(
      progressBarHeight: 8.0,
      storyChildren: [
        StoryWidget(url: "https://picsum.photos/id/237/536/354.jpg"),
        StoryWidget(
          url:
              "https://www.shutterstock.com/image-photo/demo-text-message-magnifying-glass-600nw-2491336635.jpg",
        ),
        // StoryWidget(
        //   url:
        //       "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        // ),
      ],
    ),
    StoryView(
      progressBarHeight: 8.0,
      storyChildren: [
        StoryWidget(
          url:
              "https://www.shutterstock.com/image-photo/demo-text-message-magnifying-glass-600nw-2491336635.jpg",
        ),
        StoryWidget(url: "https://picsum.photos/id/237/536/354.jpg"),
      ],
    ),
  ],
)
```

---

## 📁 Widgets Overview

### **StoryListWidget**

A horizontal scrollable list of story groups.

#### Properties:

* `storyViewList`: List of story groups (`StoryView`).

---

### **StoryView**

Represents a single story group with multiple items.

#### Properties:

* `storyChildren`: List of stories (`StoryWidget`).
* `progressBarHeight`: Height of the progress indicator.

---

### **StoryWidget**

A single story item — currently supports images.

#### Properties:

* `url`: Image or video URL.

---

## 🎨 Customization

You can extend or modify the widgets to:

* Add video playback
* Change animation speed
* Customize progress bar appearance
* Add gestures (long press, swipe, pause, etc.)

---

## 📝 Notes

* Network images require proper permissions on Android & iOS.
* Video support is commented in your example but can be enabled by integrating a video player.

---

## 🤝 Contributing

Pull requests are welcome! If you’d like to report bugs or request features, open an issue in the repository.

---

## 📄 License

MIT License © 2025
