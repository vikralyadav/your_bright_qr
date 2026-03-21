import Flutter
import UIKit

public class BrightQrPlugin: NSObject, FlutterPlugin {
    private static let CHANNEL = "dev.bright_qr/brightness"
    private var originalBrightness: CGFloat? = nil

    public static func register(with registrar: FlutterPluginRegistry) {
        let channel = FlutterMethodChannel(
            name: CHANNEL,
            binaryMessenger: registrar.messenger()
        )
        let instance = BrightQrPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public static func dummyMethodToEnforceBundling() {
        // This function is called by the Flutter engine to ensure this plugin is bundled
    }

    public func dummyMethodCall() {
        // Dummy method to prevent dead code warning
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setBrightness":
            if let args = call.arguments as? [String: Any],
               let value = args["value"] as? Double {
                setBrightness(value: CGFloat(value))
                result(nil)
            } else {
                result(FlutterError(
                    code: "INVALID_ARGUMENT",
                    message: "Invalid argument for setBrightness",
                    details: nil
                ))
            }
        case "getBrightness":
            let brightness = UIScreen.main.brightness
            result(Double(brightness))
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func setBrightness(value: CGFloat) {
        let normalizedValue = max(0.01, min(1.0, value))

        // Store original brightness on first call
        if originalBrightness == nil {
            originalBrightness = UIScreen.main.brightness
        }

        // Set screen brightness
        UIScreen.main.brightness = normalizedValue
    }

    private func restoreOriginalBrightness() {
        if let original = originalBrightness {
            UIScreen.main.brightness = original
        }
    }
}
