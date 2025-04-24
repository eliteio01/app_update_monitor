import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/version_info.dart';

class UpdateDialog extends StatelessWidget {
  final VersionInfo versionInfo;
  final bool mandatoryUpdate;
  final String title;
  final String description;
  final String updateButtonText;
  final String? laterButtonText;
  final VoidCallback? onLater;

  const UpdateDialog({
    super.key,
    required this.versionInfo,
    this.mandatoryUpdate = false,
    this.title = 'Update Available',
    this.description =
        'A new version of the app is available. Please update to continue.',
    this.updateButtonText = 'Update Now',
    this.laterButtonText,
    this.onLater,
  });

  Future<void> _launchStoreUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha((0.2 * 255).toInt()),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.system_update_alt,
                    color: Colors.blue[700],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: isDarkMode ? Colors.grey[300] : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            _VersionInfoCard(
              isDarkMode: isDarkMode,
              currentVersion: versionInfo.currentVersion,
              latestVersion: versionInfo.storeVersion,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!mandatoryUpdate && laterButtonText != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      onPressed: onLater ?? () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.blue),
                        ),
                      ),
                      child: Text(
                        laterButtonText!,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (versionInfo.playStoreLink != null) {
                      _launchStoreUrl(versionInfo.playStoreLink!);
                    } else if (versionInfo.appStoreLink != null) {
                      _launchStoreUrl(versionInfo.appStoreLink!);
                    }
                    if (mandatoryUpdate) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    shadowColor: Colors.blue.withAlpha((0.2 * 255).toInt()),
                  ),
                  child: Text(
                    updateButtonText,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionInfoCard extends StatelessWidget {
  final bool isDarkMode;
  final String currentVersion;
  final String latestVersion;

  const _VersionInfoCard({
    required this.isDarkMode,
    required this.currentVersion,
    required this.latestVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
        ),
      ),
      child: Column(
        children: [
          _VersionInfoRow(
            label: 'Current Version:',
            value: currentVersion,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 8),
          Divider(
            height: 1,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[200],
          ),
          const SizedBox(height: 8),
          _VersionInfoRow(
            label: 'Latest Version:',
            value: latestVersion,
            isDarkMode: isDarkMode,
            isLatest: true,
          ),
        ],
      ),
    );
  }
}

class _VersionInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDarkMode;
  final bool isLatest;

  const _VersionInfoRow({
    required this.label,
    required this.value,
    required this.isDarkMode,
    this.isLatest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isLatest
                ? Colors.green[600]
                : isDarkMode
                    ? Colors.grey[300]
                    : Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
