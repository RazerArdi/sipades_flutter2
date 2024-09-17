import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart' as auth;

class GoogleServiceUserRiwayat {
  static const _scopes = [sheets.SheetsApi.spreadsheetsReadonlyScope];
  final String _spreadsheetId;

  GoogleServiceUserRiwayat(this._spreadsheetId);

  Future<auth.AutoRefreshingAuthClient> _getAuthClient() async {
    try {
      final credentials = json.decode(
          await rootBundle.loadString('assets/swift-height-432208-b3-d3a0ca84f74d.json'));

      final accountCredentials = auth.ServiceAccountCredentials.fromJson(credentials);
      final authClient = await auth.clientViaServiceAccount(accountCredentials, _scopes);
      return authClient;
    } catch (e) {
      throw Exception('Failed to get auth client: $e');
    }
  }

  Future<List<Map<String, String>>> fetchUserRiwayat(String username) async {
    try {
      final authClient = await _getAuthClient();
      final sheetsApi = sheets.SheetsApi(authClient);

      final tanggalRange = 'PermintaanSurat!B2:B';
      final jenisSuratRange = 'PermintaanSurat!D2:D';
      final akunRange = 'PermintaanSurat!F2:F';
      final statusRange = 'PermintaanSurat!E2:E';

      final tanggalResponse = await sheetsApi.spreadsheets.values.get(_spreadsheetId, tanggalRange);
      final jenisSuratResponse = await sheetsApi.spreadsheets.values.get(_spreadsheetId, jenisSuratRange);
      final akunResponse = await sheetsApi.spreadsheets.values.get(_spreadsheetId, akunRange);
      final statusResponse = await sheetsApi.spreadsheets.values.get(_spreadsheetId, statusRange);

      print('Tanggal Response: ${tanggalResponse.values}');
      print('Jenis Surat Response: ${jenisSuratResponse.values}');
      print('Status Response: ${statusResponse.values}');
      print('Akun Response: ${akunResponse.values}');

      if (statusResponse.values == null ||
          tanggalResponse.values == null ||
          jenisSuratResponse.values == null ||
          akunResponse.values == null) {
        throw Exception('Null');
      }

      final List<Map<String, String>> transactions = [];

      final maxRows = [statusResponse.values!.length,tanggalResponse.values!.length, jenisSuratResponse.values!.length, akunResponse.values!.length].reduce((a, b) => a < b ? a : b);

      for (int i = 0; i < maxRows; i++) {
        final akun = akunResponse.values![i][0]?.toString() ?? '';

        if (akun == username) {
          final tanggalPengajuan = tanggalResponse.values![i][0]?.toString() ?? '';
          final jenisSurat = jenisSuratResponse.values![i][0]?.toString() ?? '';
          final status = statusResponse.values![i][0]?.toString() ?? '';

          transactions.add({
            'tanggalPengajuan': tanggalPengajuan,
            'jenisSurat': jenisSurat,
            'status': status,
          });
        }
      }

      return transactions;
    } catch (e) {
      print('Error in fetchUserRiwayat: $e');
      throw Exception('Failed to fetch user riwayat: $e');
    }
  }
}
