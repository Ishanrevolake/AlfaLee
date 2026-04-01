---
description: Steps to run the Alfa Fitness app on a macOS device using Antigravity
---

To run this project on your Mac, you can simply ask me to perform these steps, or run them yourself in the terminal.

### 1. Install Dependencies
Run this to ensure all Flutter and iOS dependencies are up to date.
// turbo
1. `flutter pub get`
// turbo
2. `cd ios && pod install && cd ..`

### 2. Run on iOS Simulator
Make sure you have an iOS Simulator open first.
// turbo
1. `flutter run -d iphonesimulator`

### 3. Run as macOS Desktop App
This will launch the app as a native Mac window.
// turbo
1. `flutter run -d macos`

### 4. Open in Xcode (For Physical Device)
// turbo
1. `open ios/Runner.xcworkspace`
