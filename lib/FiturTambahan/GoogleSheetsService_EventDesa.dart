import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleSheetsService_EventDesa {
  final String spreadsheetId;
  final String apiKey;

  GoogleSheetsService_EventDesa({required this.spreadsheetId, required this.apiKey});

  Future<List<Map<String, dynamic>>> fetchEventsData() async {
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/EVENT!A:E?key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rows = data['values'] as List<dynamic>;

      // Assuming the first row contains headers, skip it
      return rows.skip(1).map((row) {
        return {
          'judul': row[0],
          'pukul': row[1],
          'deskripsi': row[2],
          'gambar': row[3],
          'lokasi': row[4], // Format: "lat,lon"
        };
      }).toList();
    } else {
      throw Exception("Failed to load data from Google Sheets");
    }
  }
}