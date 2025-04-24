import 'package:app_update_monitor/version_checker.dart';
import 'package:app_update_monitor/update_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> checkForUpdates(BuildContext context) async {
    final versionChecker = VersionChecker(
      appleId: '123456789', // Replace with your Apple ID
      googlePlayPackageName: 'com.example.app', // Replace with your package name
    );

    try {
      final versionInfo = await versionChecker.checkVersion();
      if (versionInfo.shouldUpdate) {
        showDialog(
          context: context,
          builder: (_) => UpdateDialog(versionInfo: versionInfo),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking version: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Version Checker Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () => checkForUpdates(context),
            child: const Text('Check for Updates'),
          ),
        ),
      ),
    );
  }
}