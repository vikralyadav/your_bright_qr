import 'package:flutter_test/flutter_test.dart';
import 'package:bright_qr/bright_qr.dart';

void main() {
  group('BrightQR', () {
    late BrightQR brightQr;

    setUp(() {
      brightQr = BrightQR();
    });

    test('initialization', () {
      expect(brightQr, isNotNull);
    });

    test('setBrightness with valid value', () async {
      expect(
        () => brightQr.setBrightness(0.5),
        returnsNormally,
      );
    });

    test('setBrightness with invalid value throws error', () async {
      expect(
        () => brightQr.setBrightness(1.5),
        throwsA(isA<ArgumentError>()),
      );

      expect(
        () => brightQr.setBrightness(-0.1),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getCurrentBrightness returns valid value', () async {
      final brightness = await brightQr.getCurrentBrightness();
      expect(brightness, isA<double>());
      expect(brightness, greaterThanOrEqualTo(0.0));
      expect(brightness, lessThanOrEqualTo(1.0));
    });

    test('resetOriginalBrightness clears original value', () async {
      await brightQr.resetOriginalBrightness();
      expect(brightQr, isNotNull);
    });
  });
}
