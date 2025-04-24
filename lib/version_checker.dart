import 'package:package_info_plus/package_info_plus.dart';
import 'version_info.dart';
import 'store_services.dart';



class VersionChecker {
  final String? appleId;
  final String googlePlayPackageName;
  final String countryCode;

  VersionChecker({
    this.appleId,
    required this.googlePlayPackageName,
    this.countryCode = 'us',
  });

  Future<VersionInfo> checkVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    String? storeVersion;
    String? appStoreLink;
    String? playStoreLink;

    try {
      if (appleId != null) {
        final appStoreInfo = await StoreServices.getAppleStoreVersion(
          appleId!,
          countryCode: countryCode,
        );
        storeVersion = appStoreInfo.version;
        appStoreLink = appStoreInfo.url;
      }

      final playStoreInfo = await StoreServices.getGooglePlayVersion(
        googlePlayPackageName,
        countryCode: countryCode,
      );
      storeVersion ??= playStoreInfo.version;
      playStoreLink = playStoreInfo.url;
    } catch (e) {
      throw Exception('Failed to check version: $e');
    }

    return VersionInfo(
      currentVersion: currentVersion,
      storeVersion: storeVersion,
      appStoreLink: appStoreLink,
      playStoreLink: playStoreLink,
      shouldUpdate: shouldUpdate(currentVersion, storeVersion),
    );
  }

  bool shouldUpdate(String currentVersion, String storeVersion) {
    final currentParts = currentVersion.split('.').map(int.parse).toList();
    final storeParts = storeVersion.split('.').map(int.parse).toList();

    for (var i = 0; i < storeParts.length; i++) {
      if (i >= currentParts.length) return true;
      if (storeParts[i] > currentParts[i]) return true;
      if (storeParts[i] < currentParts[i]) return false;
    }
    return false;
  }
}
