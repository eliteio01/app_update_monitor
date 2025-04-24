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
    final apiKey = '5436a81086msh2edecfae99b6505p1cf689jsn00f0b8f42549';

    final uri = Uri.https(
      'google-play-store-scraper-api.p.rapidapi.com',
      '/app-details',
    );

    final body = json.encode({
      'language': 'en',
      'country': countryCode,
      'appID': packageName,
    });

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-rapidapi-host': 'google-play-store-scraper-api.p.rapidapi.com',
        'x-rapidapi-key': apiKey,
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Play Store version');
    }
    final data = json.decode(response.body);
    // print(data['data']['version']);

    final version = data['data']['version'] as String;
    final url = 'https://play.google.com/store/apps/details?id=$packageName';
    return (version: version, url: url);
  }
}
