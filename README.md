# Version Checker for Flutter

[![pub package](https://img.shields.io/pub/v/app_update_monitor.svg)](https://pub.dev/packages/app_update_monitor)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://github.com/eliteio01/app_update_monitor/actions/workflows/flutter.yml/badge.svg)](https://github.com/eliteio01/app_update_monitor/actions)

A lightweight Flutter package that effortlessly checks for app updates by comparing the installed version with the latest version available on the Apple App Store and Google Play Store.

## Features ✨

- ✅ **Cross-platform support** - Works on both iOS and Android
- 🔍 **Automatic store detection** - Checks the appropriate store based on platform
- 🌍 **Region-specific version checking** - Specify country code for regional stores
- 📊 **Version comparison** - Semantic version comparison (major.minor.patch)
- 🚀 **Built-in update dialog** - Pre-made customizable update dialog
- 🔗 **Store links** - Get direct links to your app in both stores
- 🛡️ **Null safety** - Fully supports sound null safety

## Installation 📦

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  app_update_monitor: ^1.0.1


Then run the following command to install the package:

```bash
flutter pub get
```

Make sure to add the necessary permissions in your `AndroidManifest.xml` for Android and `Info.plist` for iOS for network access if needed.

### Android Permissions

In your `AndroidManifest.xml` file, ensure that you have the following permissions:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS Permissions

In your `Info.plist` file, ensure you have the following permissions:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

---

## Usage

You can use the `app_update_monitor` package to check the version of your app against the versions available in the Apple App Store or Google Play Store.

### Example

```dart
import 'package:app_update_monitor/app_update_monitor.dart';

void main() async {
  const googlePlayPackageName = 'com.example.app';
  const appleId = '123456789';

  final versionChecker = VersionChecker(
    appleId: appleId, 
    googlePlayPackageName: googlePlayPackageName
  );

  final versionInfo = await versionChecker.checkVersion();

  print('Current Version: ${versionInfo.currentVersion}');
  print('Store Version: ${versionInfo.storeVersion}');
  print('Should update: ${versionInfo.shouldUpdate}');
  print('App Store Link: ${versionInfo.appStoreLink}');
  print('Play Store Link: ${versionInfo.playStoreLink}');
}
```

In the above example, replace `googlePlayPackageName` and `appleId` with your app’s package name and Apple ID respectively.

### Output

- `currentVersion`: The version of the app installed on the device.
- `storeVersion`: The latest version available in the respective app store (App Store or Google Play Store).
- `shouldUpdate`: A boolean value indicating if the app needs to be updated.
- `appStoreLink`: The link to the app in the Apple App Store.
- `playStoreLink`: The link to the app in the Google Play Store.

---

## API Documentation

The `VersionChecker` class provides a simple API to check for the latest app version:

### VersionChecker Constructor

```dart
VersionChecker({
  this.appleId,
  required this.googlePlayPackageName,
  this.countryCode = 'us',
});
```

- `appleId`: The Apple App Store ID of your app (required for iOS).
- `googlePlayPackageName`: The Google Play package name of your app (required for Android).
- `countryCode`: The country code used to get the store version, defaults to `'us'`.

### `checkVersion()` Method

```dart
Future<VersionInfo> checkVersion()
```

This method checks the current version of your app and compares it with the version in the App Store or Google Play Store.

- **Returns**: `VersionInfo` object that contains the following fields:
    - `currentVersion`: The current installed version of your app.
    - `storeVersion`: The latest version available in the app store.
    - `shouldUpdate`: A boolean indicating whether the app should be updated.
    - `appStoreLink`: The URL link to your app in the Apple App Store.
    - `playStoreLink`: The URL link to your app in the Google Play Store.

### `_shouldUpdate()` Method

```dart
bool _shouldUpdate(String currentVersion, String storeVersion)
```

This private helper method compares the current version of your app with the store version to determine if an update is required.

---

## Additional Information

### Supported Platforms

- **iOS**: Requires the app to be published on the App Store with a valid Apple ID.
- **Android**: Requires the app to be published on the Google Play Store with a valid package name.

### Contributing

If you would like to contribute to this package, feel free to fork it and submit a pull request. Contributions are welcome!

To report bugs or request features, please open an issue in the [GitHub repository](https://github.com/eliteio01/app_update_monitor).

---

## License

This package is open-source and available under the MIT License.

---

## Powered By ⚡

This package leverages these amazing packages:

- [**http**](https://pub.dev/packages/http): For making HTTP requests to the App Store and Google Play Store APIs
- [**package_info_plus**](https://pub.dev/packages/package_info_plus): For retrieving the current app version installed on the device
- [**url_launcher**](https://pub.dev/packages/url_launcher): For opening store links directly in the native app stores

We're grateful to the maintainers of these packages for their excellent work.
