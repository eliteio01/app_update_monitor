class VersionInfo {
  final String currentVersion;
  final String storeVersion;
  final String? appStoreLink;
  final String? playStoreLink;
  final bool shouldUpdate;

  VersionInfo({
    required this.currentVersion,
    required this.storeVersion,
    this.appStoreLink,
    this.playStoreLink,
    required this.shouldUpdate,
  });
}