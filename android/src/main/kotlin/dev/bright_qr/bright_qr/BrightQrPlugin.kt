package dev.bright_qr.bright_qr

import android.app.Activity
import android.content.Context
import android.provider.Settings
import android.view.WindowManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class BrightQrPlugin : io.flutter.embedding.engine.plugins.FlutterPlugin,
    io.flutter.embedding.engine.plugins.activity.ActivityAware {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var originalBrightness: Int? = null

    override fun onAttachedToEngine(binding: io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "setBrightness" -> {
                    val value = call.argument<Double>("value") ?: return@setMethodCallHandler
                    try {
                        setBrightness(value)
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("BRIGHTNESS_ERROR", e.message, null)
                    }
                }
                "getBrightness" -> {
                    try {
                        val brightness = getCurrentBrightness()
                        result.success(brightness)
                    } catch (e: Exception) {
                        result.error("BRIGHTNESS_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    private fun setBrightness(value: Double) {
        if (value < 0.0 || value > 1.0) {
            throw IllegalArgumentException("Brightness value must be between 0.0 and 1.0")
        }

        val activity = activity ?: throw RuntimeException("Activity not available")
        val context = activity.applicationContext

        // Store original brightness on first call
        if (originalBrightness == null) {
            originalBrightness = getCurrentSystemBrightness(context)
        }

        // Convert normalized value (0.0-1.0) to Android brightness (0-255)
        val brightnessValue = (value * 255).toInt().coerceIn(0, 255)

        // Set system brightness if we have permission
        try {
            if (canWriteSystemSettings(context)) {
                Settings.System.putInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, brightnessValue)
            }
        } catch (e: Exception) {
            // If system brightness fails, try window brightness
        }

        // Always set window brightness
        val params = activity.window.attributes
        params.screenBrightness = value.toFloat().coerceIn(0.01f, 1.0f)
        activity.window.attributes = params
    }

    private fun getCurrentBrightness(): Double {
        val activity = activity ?: return 0.5
        val params = activity.window.attributes
        return if (params.screenBrightness > 0) {
            params.screenBrightness.toDouble()
        } else {
            0.5
        }
    }

    private fun getCurrentSystemBrightness(context: Context): Int {
        return try {
            Settings.System.getInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, 128)
        } catch (e: Exception) {
            128
        }
    }

    private fun canWriteSystemSettings(context: Context): Boolean {
        return try {
            Settings.System.canWrite(context)
        } catch (e: Exception) {
            false
        }
    }

    companion object {
        private const val CHANNEL = "dev.bright_qr/brightness"
    }
}
