import 'package:app_update_monitor/app_update_monitor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> checkForUpdates(BuildContext context) async {
    final versionChecker = VersionChecker(
      appleId: '6741027414',
      googlePlayPackageName: 'com.etech.icpaypoint',
    );

    try {
      final versionInfo = await versionChecker.checkVersion();

      if (!mounted) return;

      if (versionInfo.shouldUpdate) {
        showDialog(
          context: context,
          builder: (_) => UpdateDialog(
            versionInfo: versionInfo,
            mandatoryUpdate: false,
            laterButtonText: 'Update later',
          ),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Version Checker Example')),
      body: Center(
        child: Builder(
          builder: (innerContext) => ElevatedButton(
            onPressed: () => checkForUpdates(innerContext),
            child: const Text('Check for Updates'),
          ),
        ),
      ),
    );
  }
}
