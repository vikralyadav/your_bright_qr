# Publishing Bright QR to Pub.dev

This guide will walk you through publishing the Bright QR package to pub.dev.

## Prerequisites

1. **Flutter SDK** - Make sure you have Flutter installed
2. **Pub.dev Account** - Sign up at https://pub.dev/ using your Google account
3. **Git** - For version control
4. **GitHub Repository** - Recommended for hosting your package source code

## Step 1: Prepare Your Package

### 1.1 Update Package Information

Edit `pubspec.yaml` and ensure all required fields are complete:

```yaml
name: bright_qr
version: 1.0.0
description: Your package description
homepage: https://github.com/yourusername/bright_qr
repository: https://github.com/yourusername/bright_qr
issue_tracker: https://github.com/yourusername/bright_qr/issues
```

### 1.2 Update Author Information

Update the iOS podspec file (`ios/bright_qr.podspec`) with your information:

```ruby
s.author           = { 'Vikral Yadav' => 'yadavvikral2003@gmail.com' }
s.homepage         = 'https://github.com/yourusername/bright_qr'
```

### 1.3 Documentation

Ensure your `README.md` is comprehensive and includes:
- Package description
- Features
- Installation instructions
- Platform-specific setup
- Usage examples
- API reference
- Troubleshooting section

## Step 2: Set Up GitHub Repository (Recommended)

### 2.1 Create a GitHub Repository

1. Go to https://github.com/new
2. Create a repository named `bright_qr`
3. Clone it locally

### 2.2 Push Your Package Code

```bash
cd your_bright_qr
git init
git add .
git commit -m "Initial commit: Bright QR package"
git branch -M main
git remote add origin https://github.com/yourusername/bright_qr.git
git push -u origin main
```

### 2.3 Create a GitHub Release

```bash
git tag v1.0.0
git push origin v1.0.0
```

## Step 3: Verify Your Package Locally

### 3.1 Test the Package

```bash
# Navigate to example directory
cd example

# Get dependencies
flutter pub get

# Run the example app
flutter run
```

### 3.2 Verify Pub Warnings

```bash
# Check your package for issues
flutter pub publish --dry-run
```

The `--dry-run` flag will check your package without actually publishing.

## Step 4: Configure Pub.dev Credentials

### 4.1 Authenticate with Pub.dev

```bash
flutter pub login
```

This will:
1. Open a browser window
2. Authenticate with your Google account
3. Grant permission for publishing

### 4.2 Verify Authentication

```bash
# This should display your authenticated user information
flutter pub pub-linter
```

## Step 5: Publish Your Package

### 5.1 Final Checklist

Before publishing, verify:
- [ ] `pubspec.yaml` has all required fields
- [ ] `README.md` is comprehensive
- [ ] `CHANGELOG.md` is up-to-date
- [ ] `LICENSE` file is present
- [ ] Example app works correctly
- [ ] No analysis warnings: `flutter analyze`
- [ ] Code is formatted: `flutter format .`
- [ ] Dry run passed: `flutter pub publish --dry-run`

### 5.2 Publish to Pub.dev

```bash
flutter pub publish
```

You'll be prompted to confirm the upload. Type `y` and press Enter.

### 5.3 Verify Publication

Your package should now be available at:
```
https://pub.dev/packages/bright_qr
```

You can also check:
```
https://pub.dev/packages/bright_qr/versions
```

## Step 6: Post-Publication

### 6.1 Update Your Package

When you want to publish a new version:

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Commit changes: `git add . && git commit -m "v1.0.1"`
4. Tag the release: `git tag v1.0.1`
5. Push to GitHub: `git push && git push --tags`
6. Publish: `flutter pub publish`

### 6.2 Create GitHub Release Notes

For each version, create a release on GitHub:

1. Go to https://github.com/yourusername/bright_qr/releases
2. Click "New release"
3. Select the tag (e.g., v1.0.1)
4. Add release notes describing changes
5. Publish the release

## Troubleshooting

### "Package name is reserved"

If you get this error, someone may have already published a package with that name. Choose a different name.

### "Pub validation failed"

Check the error messages from `flutter pub publish --dry-run` for specific issues.

### "Missing requirements"

Ensure all required files are present:
- pubspec.yaml
- LICENSE
- README.md
- CHANGELOG.md
- lib/ directory with source code

### "Platform channel not found"

Ensure:
- Android code is in `android/` directory
- iOS code is in `ios/` directory
- Package names are correctly configured in `pubspec.yaml` and platform files

### "Analysis warnings"

Fix any analysis warnings before publishing:
```bash
flutter analyze
flutter format .
```

## Version Management

### Semantic Versioning

Use semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes
- **MINOR** (1.0.0 → 1.1.0): New features, backward compatible
- **PATCH** (1.0.0 → 1.0.1): Bug fixes, backward compatible

### Version History

Keep `CHANGELOG.md` updated with:
- Version number
- Release date
- New features
- Bug fixes
- Breaking changes (if any)

## Marketing Your Package

### 6.1 Share on Social Media

Announce your package on:
- Twitter/X
- Flutter Community Slack
- Reddit (r/FlutterDev)
- Dev.to

### 6.2 Documentation

- Create a comprehensive README
- Add example code
- Create a demo video (optional)
- Write a blog post about your package

### 6.3 GitHub

- Add topics: "flutter", "qr-code", "brightness"
- Write a good description
- Add badges to your README

## Additional Resources

- [Pub.dev Documentation](https://dart.dev/tools/pub/publishing)
- [Flutter Plugin Documentation](https://flutter.dev/docs/development/packages-and-plugins/developing-packages)
- [Semantic Versioning](https://semver.org/)
- [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)

## Support

If you encounter issues:

1. Check the [Pub.dev Help](https://pub.dev/help)
2. Review [Flutter Issues](https://github.com/flutter/flutter/issues)
3. Ask on [Flutter Community Slack](https://flutter-community.slack.com/)
4. Create an issue on your GitHub repository

---

**Congratulations!** Your Bright QR package is now available to developers worldwide on pub.dev!
