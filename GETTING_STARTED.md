# Getting Started with Bright QR Development

This guide will help you set up and develop the Bright QR package.

## Project Structure

```
your_bright_qr/
├── lib/                          # Dart package code
│   ├── bright_qr.dart           # Main export file
│   └── src/
│       ├── bright_qr.dart       # Main BrightQR class
│       └── bright_qr_platform_interface.dart
├── android/                      # Android native code
│   └── src/main/kotlin/...
├── ios/                          # iOS native code
│   └── Classes/BrightQrPlugin.swift
├── example/                      # Example Flutter app
│   └── lib/main.dart
├── test/                         # Unit tests
├── pubspec.yaml                  # Package configuration
├── README.md                     # Package documentation
├── CHANGELOG.md                  # Version history
├── LICENSE                       # MIT License
└── PUBLISHING_GUIDE.md          # Instructions for publishing
```

## Prerequisites

- Flutter SDK (>=2.0.0)
- Dart SDK (>=2.18.0)
- Android SDK (for Android development)
- Xcode (for iOS development)
- Git

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/bright_qr.git
cd your_bright_qr
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Example App

```bash
cd example
flutter pub get
flutter run
```

## Development Workflow

### Code Format

Format all Dart code:

```bash
flutter format .
```

### Run Analysis

Check for errors and lints:

```bash
flutter analyze
```

### Run Tests

Execute unit tests:

```bash
flutter test
```

### Build Example

Build the example app for iOS or Android:

```bash
# iOS
cd example
flutter build ios

# Android
cd example
flutter build apk
```

## Architecture

### Dart Side (lib/)

- `BrightQR` class: Main public API
- Uses `MethodChannel` to communicate with platform code
- Channel name: `dev.bright_qr/brightness`

### Android Side (android/)

- `BrightQrPlugin.kt`: Handles method calls from Dart
- Uses Android Settings API to manage screen brightness
- Handles permissions for Android 6.0+

### iOS Side (ios/)

- `BrightQrPlugin.swift`: Handles method calls from Dart
- Uses UIScreen API to manage brightness
- No special permissions required

## Platform Channel Communication

### Methods Called from Dart

1. **setBrightness(double value)**
   - Parameter: `value` (0.0 to 1.0)
   - Converts to Android brightness (0-255)
   - Stores original brightness on first call

2. **getBrightness()**
   - Returns current brightness (0.0 to 1.0)

3. **restoreOriginalBrightness()**
   - Restores brightness to saved value

## Testing

### Unit Tests

Located in `test/bright_qr_test.dart`:

```bash
flutter test
```

### Integration Testing

Test on real devices:

```bash
# Android
flutter run --release

# iOS
flutter run --release
```

## Building for Different Platforms

### Android Setup

1. Ensure Android SDK is installed
2. Android Studio or command-line tools configured
3. Emulator or physical device connected

```bash
cd example
flutter run
```

### iOS Setup

1. Ensure Xcode is installed
2. CocoaPods installed (`gem install cocoapods`)
3. Simulator or physical device available

```bash
cd example
flutter run
```

## Common Issues

### Android Permission Issues

**Problem**: Brightness changes not working on Android

**Solution**:
1. Verify `android.permission.WRITE_SETTINGS` is declared
2. For Android 6.0+, request permissions at runtime
3. Check device settings allow write to system settings

### iOS Not Changing Brightness

**Problem**: Brightness API not responding

**Solution**:
1. Ensure app has focus
2. Try setting brightness in app before camera
3. Check device brightness is adjustable

### Build Errors

**Mac M1/M2 Issues**:
```bash
arch -x86_64 flutter pub get
flutter build ios --simulator
```

## Publishing

See [PUBLISHING_GUIDE.md](PUBLISHING_GUIDE.md) for detailed instructions on publishing to pub.dev.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Write tests for new features

## Version Management

Current version: **1.0.0**

### Semantic Versioning

- **1.0.0** → **2.0.0**: Breaking changes
- **1.0.0** → **1.1.0**: New features
- **1.0.0** → **1.0.1**: Bug fixes

Always update:
1. `pubspec.yaml` version
2. `CHANGELOG.md` with changes
3. Git tags for releases

## Documentation

### API Documentation

Generate docs:

```bash
dartdoc
```

Documentation will be generated in `doc/api/`

### README

Update `README.md` with:
- Clear package description
- Installation steps
- Usage examples
- Platform-specific configuration
- Troubleshooting section

## Support

- GitHub Issues: [Report bugs](https://github.com/yourusername/bright_qr/issues)
- GitHub Discussions: [Ask questions](https://github.com/yourusername/bright_qr/discussions)
- Flutter Community: [Join the community](https://flutter-community.slack.com/)

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## Useful Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Platform Channels Guide](https://flutter.dev/docs/development/platform-integration/platform-channels)
- [Pub.dev Publishing Guide](https://dart.dev/tools/pub/publishing)
- [GitHub Guides](https://guides.github.com)

---

Happy coding! 🚀
