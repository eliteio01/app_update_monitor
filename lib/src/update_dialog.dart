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
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          const SizedBox(height: 8),
          Text('Current version: ${versionInfo.currentVersion}'),
          Text('Latest version: ${versionInfo.storeVersion}'),
        ],
      ),
      actions: [
        if (!mandatoryUpdate && laterButtonText != null)
          TextButton(
            onPressed: onLater ?? () => Navigator.pop(context),
            child: Text(laterButtonText!),
          ),
        TextButton(
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
          child: Text(updateButtonText),
        ),
      ],
    );
  }
}
