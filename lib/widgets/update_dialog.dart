import 'package:flutter/material.dart';

import '../models/version_info.dart';

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
    this.description = 'A new version of the app is available. Please update to continue.',
    this.updateButtonText = 'Update Now',
    this.laterButtonText,
    this.onLater,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        if (!mandatoryUpdate && laterButtonText != null)
          TextButton(
            onPressed: onLater ?? () => Navigator.pop(context),
            child: Text(laterButtonText!),
          ),
        TextButton(
          onPressed: () {
            if (versionInfo.playStoreLink != null) {
              // Open play store
            } else if (versionInfo.appStoreLink != null) {
              // Open app store
            }
          },
          child: Text(updateButtonText),
        ),
      ],
    );
  }
}