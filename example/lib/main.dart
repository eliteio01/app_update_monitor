import 'package:app_update_monitor/app_update_monitor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> checkForUpdates() async {
    final versionChecker = VersionChecker(
      appleId: '123456789',
      googlePlayPackageName: 'com.example.app',
    );

    try {
      final versionInfo = await versionChecker.checkVersion();

      if (!mounted) return;

      if (versionInfo.shouldUpdate) {
        showDialog(
          context: context,
          builder: (_) => UpdateDialog(versionInfo: versionInfo),
        );
      }
    } catch (e) {
      if (!mounted) return;
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
            onPressed: checkForUpdates,
            child: const Text('Check for Updates'),
          ),
        ),
      ),
    );
  }
}
