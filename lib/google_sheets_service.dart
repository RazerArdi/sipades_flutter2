import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchCredentials(String sheetId, String range) async {
  final url = 'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$range?key=AIzaSyBDNmKHYwvVVcG-VaPBy6uW63nu7ri5rXc';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final rows = data['values'] as List;
    Map<String, String> credentials = {};

    for (var row in rows) {
      if (row.length >= 2) {
        credentials[row[0]] = row[1];
      }
    }
    return credentials;
  } else {
    throw Exception('Failed to load data');
  }
}
