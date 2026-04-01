# Alfa Fitness: macOS Setup and Run Guide

If you want to run this Flutter project natively as a macOS desktop app, follow these steps on your MacBook:

## 1. Prerequisites
Ensure your MacBook is set up for macOS and iOS development:
- **Xcode**: Install the latest version from the Mac App Store. Run it once to accept the license agreements.
- **Flutter SDK**: Ensure Flutter is installed and added to your system `PATH`.
- **CocoaPods**: Required for plugins. Run `sudo gem install cocoapods` in your Mac terminal.

## 2. Enable macOS Desktop Support
If the macOS folder isn't fully initialized, run the following in your terminal at the root of `delloFitness`:
```bash
# Ensure macOS support is enabled for your Flutter installation
flutter config --enable-macos-desktop

# Generate or repair the macOS native project files
flutter create --platforms=macos .
```

## 3. Run the App
To launch the app on your Mac, simply open a terminal in the project directory and run:
```bash
flutter run -d macos
```

## 4. Visual Optimization
Because this app is designed with a mobile-first UI layout:
- Try manually resizing the native macOS window to a vertical "phone" shape when the app opens for the best experience.
- The `SafeArea` and flexible UI components will automatically adapt to the window resize!

## Troubleshooting
- **No Supported Devices**: If `flutter run` complains about missing devices, run `flutter doctor` to ensure Xcode is properly detected.
- **Permission Errors**: If prompted by macOS for Network Access or Developer Tools, explicitly click **Allow** so the app can communicate with the data services.
