import 'package:flutter/material.dart';
import 'package:bright_qr/bright_qr.dart';

void main() {
  runApp(const BrightQRExample());
}

class BrightQRExample extends StatelessWidget {
  const BrightQRExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bright QR Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const BrightQRDemoPage(),
    );
  }
}

class BrightQRDemoPage extends StatefulWidget {
  const BrightQRDemoPage({Key? key}) : super(key: key);

  @override
  State<BrightQRDemoPage> createState() => _BrightQRDemoPageState();
}

class _BrightQRDemoPageState extends State<BrightQRDemoPage> {
  final brightQr = BrightQR();
  double _currentBrightness = 0.5;
  String _statusMessage = 'Ready to scan QR codes';
  bool _qrScannerActive = false;

  @override
  void initState() {
    super.initState();
    _getBrightness();
  }

  Future<void> _getBrightness() async {
    try {
      final brightness = await brightQr.getCurrentBrightness();
      setState(() {
        _currentBrightness = brightness;
      });
    } catch (e) {
      _showError('Failed to get brightness: $e');
    }
  }

  Future<void> _openQRScanner() async {
    try {

      await brightQr.setBrightness(1.0);

      setState(() {
        _qrScannerActive = true;
        _statusMessage = 'QR Scanner opened - Brightness set to maximum';
      });
      await Future.delayed(const Duration(seconds: 2));

      // In a real app, you would integrate with a QR scanner package
      // like mobile_scanner or qr_code_scanner
      _showStatus('QR Code scanned: example_qr_data_12345');
    } catch (e) {
      _showError('Failed to open QR scanner: $e');
    }
  }

  Future<void> _closeQRScanner() async {
    try {
  
      await brightQr.restoreOriginalBrightness();

      setState(() {
        _qrScannerActive = false;
        _statusMessage = 'QR Scanner closed - Brightness restored';
      });

      _getBrightness();
    } catch (e) {
      _showError('Failed to close QR scanner: $e');
    }
  }

  Future<void> _setMaxBrightness() async {
    try {
      await brightQr.setBrightness(1.0);
      _getBrightness();
      _showStatus('Brightness set to maximum (100%)');
    } catch (e) {
      _showError('Failed to set brightness: $e');
    }
  }

  Future<void> _setMinBrightness() async {
    try {
      await brightQr.setBrightness(0.1);
      _getBrightness();
      _showStatus('Brightness set to minimum (10%)');
    } catch (e) {
      _showError('Failed to set brightness: $e');
    }
  }

  Future<void> _setMidBrightness() async {
    try {
      await brightQr.setBrightness(0.5);
      _getBrightness();
      _showStatus('Brightness set to medium (50%)');
    } catch (e) {
      _showError('Failed to set brightness: $e');
    }
  }

  Future<void> _restoreBrightness() async {
    try {
      await brightQr.restoreOriginalBrightness();
      _getBrightness();
      _showStatus('Brightness restored to original value');
    } catch (e) {
      _showError('Failed to restore brightness: $e');
    }
  }

  void _showStatus(String message) {
    setState(() {
      _statusMessage = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bright QR Demo'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_statusMessage),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _currentBrightness,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Brightness: ${(_currentBrightness * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // QR Scanner Actions
            const Text(
              'QR Scanner Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _qrScannerActive ? null : _openQRScanner,
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Open QR Scanner'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: !_qrScannerActive ? null : _closeQRScanner,
              icon: const Icon(Icons.close),
              label: const Text('Close QR Scanner'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),

            const SizedBox(height: 24),

            // Brightness Actions
            const Text(
              'Manual Brightness Control',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _setMaxBrightness,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Max\n(100%)'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _setMidBrightness,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Mid\n(50%)'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _setMinBrightness,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Min\n(10%)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _restoreBrightness,
              icon: const Icon(Icons.restore),
              label: const Text('Restore Original'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),

            const SizedBox(height: 24),

            // Info Card
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '💡 How it Works',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Click "Open QR Scanner" to automatically set brightness to maximum\n'
                      '2. Scan your QR code\n'
                      '3. Click "Close QR Scanner" to restore original brightness\n'
                      '\n'
                      'You can also manually control brightness using the buttons above.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
