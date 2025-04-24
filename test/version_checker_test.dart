import 'package:app_update_monitor/version_checker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late VersionChecker versionChecker;

  setUp(() {
    versionChecker = VersionChecker(
      appleId: '123456789',
      googlePlayPackageName: 'com.example.app',
    );
  });

  test('shouldUpdate returns true when store version is higher', () {
    expect(versionChecker.shouldUpdate('1.0.0', '1.0.1'), true);
    expect(versionChecker.shouldUpdate('1.0.0', '1.1.0'), true);
    expect(versionChecker.shouldUpdate('1.0.0', '2.0.0'), true);
  });

  test('shouldUpdate returns false when versions are equal', () {
    expect(versionChecker.shouldUpdate('1.0.0', '1.0.0'), false);
  });

  test('shouldUpdate returns false when current version is higher', () {
    expect(versionChecker.shouldUpdate('1.0.1', '1.0.0'), false);
    expect(versionChecker.shouldUpdate('1.1.0', '1.0.0'), false);
    expect(versionChecker.shouldUpdate('2.0.0', '1.0.0'), false);
  });
}
