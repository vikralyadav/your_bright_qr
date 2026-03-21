#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint bright_qr.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'bright_qr'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter package that automatically manages device brightness for QR code scanning.'
  s.description      = <<-DESC
A Flutter package that automatically manages device brightness when handling QR codes. When a QR code
is opened, brightness is automatically set to maximum for better scanning experience, and restored to
its original value when disposed.
                       DESC
  s.homepage         = 'https://github.com/yourusername/bright_qr'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
