# Bright QR

A Flutter package that automatically manages device brightness when handling QR codes. When a QR scanner is opened, brightness is automatically set to maximum for better scanning experience, and restored to its original value when disposed.

## Features

- 🌟 Automatically sets brightness to maximum when QR code scanner opens
- 🔄 Restores original brightness when QR code is disposed
- 📱 Works on both Android and iOS
- 🔧 Easy-to-use API with platform channel integration
- ⚡ Non-blocking, efficient brightness management

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  bright_qr: ^1.0.0
```

## Platform-Specific Setup

### Android

Add the following permissions to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.WRITE_SETTINGS" />
```

Add `android.permission.WRITE_SETTINGS` to your permissions:

```xml
<uses-permission android:name="android.permission.CHANGE_SCREEN_BRIGHTNESS" />
<uses-permission android:name="android.permission.WRITE_SETTINGS" />
```

### iOS

No additional setup required. The package uses native iOS APIs to manage brightness.

## Usage

```dart
import 'package:bright_qr/bright_qr.dart';

// Create an instance of BrightQR
final brightQr = BrightQR();

// Increase brightness to maximum
await brightQr.setBrightness(1.0);

// Restore original brightness
await brightQr.restoreOriginalBrightness();

// Get current brightness
final currentBrightness = await brightQr.getCurrentBrightness();
print('Current brightness: $currentBrightness');
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:bright_qr/bright_qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final brightQr = BrightQR();
  double _currentBrightness = 0.5;

  @override
  void initState() {
    super.initState();
    _getBrightness();
  }

  Future<void> _getBrightness() async {
    final brightness = await brightQr.getCurrentBrightness();
    setState(() {
      _currentBrightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Bright QR')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Brightness: ${(_currentBrightness * 100).toStringAsFixed(0)}%',
              ),
              ElevatedButton(
                onPressed: () async {
                  await brightQr.setBrightness(1.0);
                  _getBrightness();
                },
                child: const Text('Increase Brightness'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await brightQr.restoreOriginalBrightness();
                  _getBrightness();
                },
                child: const Text('Restore Original Brightness'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## API Reference

### `BrightQR()`

Initialize BrightQR instance.

### `setBrightness(double value)`

Set the device brightness to a specific value (0.0 to 1.0).

- **Parameters:**
  - `value`: A double value between 0.0 (minimum) and 1.0 (maximum)
- **Returns:** `Future<void>`

### `restoreOriginalBrightness()`

Restore the device brightness to its original value before the first `setBrightness` call.

- **Returns:** `Future<void>`

### `getCurrentBrightness()`

Get the current device brightness value.

- **Returns:** `Future<double>` - A value between 0.0 and 1.0

## Troubleshooting

### Android: Permission Issues

If you encounter permission issues on Android, ensure that:
1. `android.permission.WRITE_SETTINGS` is declared in AndroidManifest.xml
2. For Android 6.0+, you may need to request the permission at runtime using a package like `permission_handler`

### iOS: Brightness Not Changing

If brightness changes don't work on iOS:
1. Ensure the app has permission to access device settings
2. Try adjusting brightness in the app before accessing the camera

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This package is licensed under the MIT License - see the LICENSE file for details.

## Author

Created with ❤️ for Flutter developers

## Support

For issues or questions, please visit [GitHub Issues](https://github.com/yourusername/bright_qr/issues)
