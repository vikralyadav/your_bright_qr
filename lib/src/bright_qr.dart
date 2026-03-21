import 'package:flutter/services.dart';

/// A Flutter package that automatically manages device brightness for QR code scanning.
/// 
/// When a QR code is opened, brightness is automatically set to maximum for better
/// scanning experience, and restored to its original value when disposed.
class BrightQR {
  static const platform = MethodChannel('dev.bright_qr/brightness');
  
  double? _originalBrightness;

  /// Set the device brightness to a specific value.
  /// 
  /// [value] should be between 0.0 (minimum) and 1.0 (maximum).
  /// If this is the first time calling this method, the original brightness
  /// will be saved for later restoration.
  /// 
  /// Example:
  /// ```dart
  /// final brightQr = BrightQR();
  /// await brightQr.setBrightness(1.0); // Maximum brightness
  /// ```
  Future<void> setBrightness(double value) async {
    if (value < 0.0 || value > 1.0) {
      throw ArgumentError('Brightness value must be between 0.0 and 1.0');
    }

    try {
      // Store original brightness on first call
      if (_originalBrightness == null) {
        _originalBrightness = await getCurrentBrightness();
      }

      await platform.invokeMethod<void>('setBrightness', {'value': value});
    } on PlatformException catch (e) {
      throw Exception('Failed to set brightness: ${e.message}');
    }
  }

  /// Restore the device brightness to its original value.
  /// 
  /// This should be called when the QR code scanner is disposed
  /// to restore the user's preferred brightness level.
  /// 
  /// Example:
  /// ```dart
  /// final brightQr = BrightQR();
  /// await brightQr.restoreOriginalBrightness();
  /// ```
  Future<void> restoreOriginalBrightness() async {
    try {
      if (_originalBrightness != null) {
        await platform.invokeMethod<void>(
          'setBrightness',
          {'value': _originalBrightness},
        );
      }
    } on PlatformException catch (e) {
      throw Exception('Failed to restore brightness: ${e.message}');
    }
  }

  /// Get the current device brightness value.
  /// 
  /// Returns a value between 0.0 (minimum) and 1.0 (maximum).
  /// 
  /// Example:
  /// ```dart
  /// final brightQr = BrightQR();
  /// final brightness = await brightQr.getCurrentBrightness();
  /// print('Current brightness: $brightness');
  /// ```
  Future<double> getCurrentBrightness() async {
    try {
      final brightness = await platform.invokeMethod<double>('getBrightness');
      return brightness ?? 0.5;
    } on PlatformException catch (e) {
      throw Exception('Failed to get brightness: ${e.message}');
    }
  }

  /// Reset the stored original brightness value.
  /// 
  /// This is useful if you want to recapture the original brightness
  /// after the device settings have changed.
  Future<void> resetOriginalBrightness() async {
    _originalBrightness = null;
  }
}
