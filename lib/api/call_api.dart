import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future get(
    String url, {
    required Function(dynamic value) onSuccess,
    required Function(String error) onError,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        onSuccess(json.decode(response.body));
      } else {
        onError('Error: ${response.body}');
      }
    } catch (e) {
      onError(e.toString());
    }

    return;
  }
}
