import 'dart:convert';
import 'package:http/http.dart' as http;

class StoreServices {
  static Future<({String version, String url})> getAppleStoreVersion(
      String appleId, {
        String countryCode = 'us',
      }) async {
    final uri = Uri.https(
      'itunes.apple.com',
      '/lookup',
      {'id': appleId, 'country': countryCode},
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch App Store version');
    }

    final data = json.decode(response.body);
    if (data['resultCount'] == 0) {
      throw Exception('App not found in App Store');
    }

    final version = data['results'][0]['version'] as String;
    final url = data['results'][0]['trackViewUrl'] as String;
    return (version: version, url: url);
  }

  static Future<({String version, String url})> getGooglePlayVersion(
      String packageName, {
        String countryCode = 'us',
      }) async {
    final uri = Uri.https(
      'play.google.com',
      '/store/apps/details',
      {'id': packageName, 'hl': 'en', 'gl': countryCode},
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Play Store version');
    }

    final version = _parseGooglePlayVersion(response.body);
    final url = 'https://play.google.com/store/apps/details?id=$packageName';
    return (version: version, url: url);
  }

  static String _parseGooglePlayVersion(String html) {
    const versionStart =
        'Current Version</div><span class="htlgb"><div class="IQ1z0d"><span class="htlgb">';
    const versionEnd = '</span></div></span>';

    final startIndex = html.indexOf(versionStart);
    if (startIndex == -1) {
      throw Exception('Version not found in Play Store page');
    }

    final endIndex = html.indexOf(versionEnd, startIndex + versionStart.length);
    return html.substring(startIndex + versionStart.length, endIndex);
  }
}
