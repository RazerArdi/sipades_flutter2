import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class Google_Service_AdminBeranda {
  // ID spreadsheet Google Sheets yang digunakan
  final String _spreadsheetId = '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI';
  // Rentang data yang akan diambil
  final String _rangeSessionSummary = 'PermintaanSurat!B2:B';
  final String _rangeDemographicData = 'DATA!H2:H';
  final String _rangeTotalPopulation = 'DATA!A2:A';
  final String _rangeSuccessRate = 'PermintaanSurat!E2:E';

  // Kredensial akun layanan untuk mengakses Google Sheets API
  final _credentials = '''
{
  "type": "service_account",
  "project_id": "swift-height-432208-b3",
  "private_key_id": "d3a0ca84f74d32aa62c97ffc024e5ff9453c4bcf",
  "private_key": "-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1znQtwfhiMFMU\\nxxBKKESDUQarkiZD2eYiiUwpLla2k0qd7VC/x4/EdFHzaLQ4Tv9Bl4oUijNgtyxX\\n/7DyH3kmPvM9Ow48uOuimXWG+GlIDl3U8GSl8kgjgQP7lGI4A8b9LIA0WtBRufri\\nchrcuGL/JQuqp2qkwPbta2/HXoRGDtHRotnIg7Od584Q+pI9RoFk2RutiR7YYz/s\\nMKr6bZHdY82/8fV2O7ehlIPvcDYI2qn+oI1WunOqyG8TLxllJN18kVJOMyDmEd2I\\nO99zOPifTdbktvyA8DhOLc4gnNuFfZxlxpXDdi+0yi5uhDlAvrPXZl1qjmNGquVU\\nXbsz3ltHAgMBAAECggEAMsXl9zNxCQbi5O4U9Ajb3Wp++OJXcmKDnUiHrwaEa/el\\ngoZYoz55vY0Yp+gpUIJrUeeexc60u4FcTnUXdv7oKBCzgHmiJ74i/GVsB5YPXPK6\\nLLI4AYowsE2jDZrqdSdE5saLRVPJUtGkKaJhMxwBdazkXbPkmf9T1olHDcAtI50d\\nY2QNNlI4K5ghqVD4h3Kho/97wyn6rD2GhnblxeA2LHUY6fA+qGY1jbOPM9f1NdPU\\n9XAxj5oMcCamT87GU9s1gk3eRL1MbPX/6mei4AB9fAOw1/lJoRfy1mtc8AMgDHkH\\ny+A/6eI3VNGX0ECbedtXDtSmc5BBsAWB2GOGNcOElQKBgQD1lz/1tsU7dhxEKBer\\ngo6/Bnfp7lseiw7SOKqNjr7M9+UOTUcEptUYGMfAEltc6+2cj6ZvZ94wjE+EyOix\\nx/RbeHS8RyBMahKKtuasO/D64E4qAyqX2uneQTC1R8DR+SO7fOu34dyb647T2PJu\\nBIcKpF5kihloy089I2nKgGPk6wKBgQC9gx7QXsPpFVlJuvi8xqkdC63IzI/g7QEj\\nZQWjuLXPm7dOhacw1Zla8xf9SEF8xAl4auI2f1NDrsbRNGs7JaI7fFGsXRYvQ6+j\\n8AUZQsYHmZg4pTvjfFsg/7unNANRwzi7ckALuOjRi77PcTCkk0FOaAL3wwZp1jV7\\nHK/0SrC8FQKBgGYzqDlP8yo4j7DJYnhMX60dOv/N4nuGcQeI72jzc3GG4/qcrCZC\\na0GY5l+HBCBaSkqx+Rg5iFx5t4nRtgxt4sHCEgpcKxPBvK+fR8V7OGCewch4Atyp\\nDFQimuuFzbdTz8vxQ4MFajI0x/5fNRwVpEEIgAOk+MgEe5g8yYStA2U7AoGBAKO6\\nIGkNNlytIRLeAf+18m0xpdaRRMyidhVKNfEYp5rRgTDJr4Q1ReSZmOQuBMXx5+yt\\nCvriTeFvoj0j+HCFNwAFi9pKIdx7sccEmqMUWVo/jI+D0ZXb3i9IQatW+HcvHlhz\\ngHmgKyS+gv9dXxUQU5+VpNrBF01gz5upUSrRTJdxAoGAWESQSvgsyXpZCxOD+oEu\\npK4VvMCJwMLi65HS6/w2CtE+NGh7H8ucStHC11kwiWO/pxxGj9FZG2wyrE7x0OM3\\n4XzqeUIQ24u71XODRYPEILQQ372onBWo4TrvRo3FdbdilnNKuiCQAG5ZQxPkWqCn\\nDg39FC1dN+D30eySOhgbEoQ=\\n-----END PRIVATE KEY-----\\n",
  "client_email": "sipades@swift-height-432208-b3.iam.gserviceaccount.com",
  "client_id": "101651181460493147098",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sipades%40swift-height-432208-b3.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

  // Fungsi untuk mengambil data demografis dari Google Sheets
  Future<List<DemographicData>> getDemographicData() async {
    final client = await _getAuthClient();
    final sheetsApi = sheets.SheetsApi(client);

    // Ambil data dari sheet dengan rentang yang telah ditentukan
    final response = await sheetsApi.spreadsheets.values.get(
      _spreadsheetId,
      _rangeDemographicData,
    );

    final values = response.values ?? [];
    return values.map((row) {
      final dateString = row[0] as String;
      print('Date String: $dateString'); // Debug log untuk tanggal

      final dateOfBirth = DateFormat('dd/MM/yyyy').parse(dateString);
      final age = _calculateAge(dateOfBirth); // Hitung umur berdasarkan tanggal lahir
      final label = row[1] as String;
      return DemographicData(label: label, value: age.toDouble());
    }).toList();
  }

  // Fungsi untuk menghitung umur berdasarkan tanggal lahir
  int _calculateAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    // Cek apakah bulan dan tanggal sekarang lebih kecil dari tanggal lahir
    if (now.month < dateOfBirth.month || (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--; // Kurangi usia jika belum melewati ulang tahun tahun ini
    }
    return age;
  }

  // Fungsi untuk mengambil ringkasan sesi
  Future<List<ChartData>> getSessionSummary() async {
    final client = await _getAuthClient();
    final sheetsApi = sheets.SheetsApi(client);

    final response = await sheetsApi.spreadsheets.values.get(
      _spreadsheetId,
      _rangeSessionSummary,
    );

    final values = response.values ?? [];
    print('Session Summary: $values'); // Debug log untuk ringkasan sesi

    return values.map((row) {
      // Pastikan row memiliki kolom yang cukup
      if (row.length < 2) {
        print('Skipping row with insufficient data: $row'); // Debug log jika data tidak cukup
        return ChartData(date: DateTime.now(), count: 0);
      }

      final date = DateFormat('dd-MM-yyyy').parse(row[0] as String);
      final count = int.tryParse(row[1] as String) ?? 0;
      return ChartData(date: date, count: count);
    }).toList();
  }

  // Fungsi untuk menghitung total populasi dari data yang diambil
  Future<int> getTotalPopulation() async {
    final client = await _getAuthClient();
    final sheetsApi = sheets.SheetsApi(client);

    final response = await sheetsApi.spreadsheets.values.get(
      _spreadsheetId,
      _rangeTotalPopulation,
    );

    final values = response.values ?? [];

    // Log data yang diterima untuk debugging
    print('Data Total Population: $values');

    // Pastikan bahwa data yang diambil diubah menjadi integer dengan benar
    final totalPopulation = values
        .where((row) => row.isNotEmpty) // Filter out empty rows
        .map((row) {
      // Guard against rows without data
      if (row.isEmpty) {
        print('Skipping empty row'); // Debug log
        return 0;
      }
      final value = row[0] as String;
      final parsedValue = int.tryParse(value) ?? 0;
      return parsedValue;
    })
        .reduce((a, b) => a + b);

    print('Total Population Calculated: $totalPopulation'); // Debug log

    return totalPopulation;
  }

  // Fungsi untuk menghitung tingkat kesuksesan/berhasil
  Future<double> getSuccessRate() async {
    final client = await _getAuthClient();
    final sheetsApi = sheets.SheetsApi(client);

    final response = await sheetsApi.spreadsheets.values.get(
      _spreadsheetId,
      _rangeSuccessRate,
    );

    final values = response.values ?? [];
    final successValues = values.map((row) => double.tryParse(row[0] as String) ?? 0).toList();

    if (successValues.isEmpty) return 0.0;

    final total = successValues.reduce((a, b) => a + b); // Jumlahkan semua nilai sukses/berhasil
    return total / successValues.length; // Hitung rata-rata tingkat kesuksesan
  }

  // Fungsi untuk otentikasi ke Google Sheets API menggunakan akun layanan
  Future<AuthClient> _getAuthClient() async {
    final credentials = ServiceAccountCredentials.fromJson(_credentials);
    final scopes = [sheets.SheetsApi.spreadsheetsScope];
    return await clientViaServiceAccount(credentials, scopes);
  }
}

// Kelas untuk data demografis
class DemographicData {
  final String label;
  final double value;

  DemographicData({required this.label, required this.value});
}

// Kelas untuk data grafik
class ChartData {
  final DateTime date;
  final int count;

  ChartData({required this.date, required this.count});
}
