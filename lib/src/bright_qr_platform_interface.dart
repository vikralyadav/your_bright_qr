/// Platform interface for brightness management.
/// 
/// This class defines the contract for platform-specific implementations
/// on Android and iOS.
abstract class BrightQRPlatform {
  /// Set the device brightness to a specific value (0.0 to 1.0).
  Future<void> setBrightness(double value);

  /// Get the current device brightness (0.0 to 1.0).
  Future<double> getBrightness();

  /// Restore original brightness.
  Future<void> restoreOriginalBrightness();
}
