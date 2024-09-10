import 'dart:math'; // Untuk fungsi-fungsi matematika, termasuk pembuatan ID unik
import 'package:googleapis/sheets/v4.dart' as sheets; // Untuk berinteraksi dengan Google Sheets API
import 'package:googleapis_auth/auth_io.dart'; // Untuk autentikasi dengan Google API

// Kelas ini mengatur koneksi dan operasi dengan Google Sheets
class GoogleSheetsService {
  final String sheetId; // ID dari spreadsheet yang ingin diakses
  sheets.SheetsApi? _sheetsApi; // Instance dari SheetsApi yang digunakan untuk komunikasi dengan Google Sheets

  // Konstruktor kelas yang memulai proses autentikasi dan inisialisasi
  GoogleSheetsService(this.sheetId) {
    _initializeSheetsApi(); // Inisialisasi Sheets API
  }

  // Fungsi untuk menginisialisasi SheetsApi jika belum diinisialisasi
  Future<void> _initializeSheetsApi() async {
    if (_sheetsApi != null) return; // Jika sudah diinisialisasi, tidak perlu ulang

    final scopes = [sheets.SheetsApi.spreadsheetsScope]; // Scope akses untuk Google Sheets API
    final credentials = ServiceAccountCredentials.fromJson(r'''
      {
        "private_key_id": "d3a0ca84f74d32aa62c97ffc024e5ff9453c4bcf",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1znQtwfhiMFMU\nxxBKKESDUQarkiZD2eYiiUwpLla2k0qd7VC/x4/EdFHzaLQ4Tv9Bl4oUijNgtyxX\n/7DyH3kmPvM9Ow48uOuimXWG+GlIDl3U8GSl8kgjgQP7lGI4A8b9LIA0WtBRufri\nchrcuGL/JQuqp2qkwPbta2/HXoRGDtHRotnIg7Od584Q+pI9RoFk2RutiR7YYz/s\nMKr6bZHdY82/8fV2O7ehlIPvcDYI2qn+oI1WunOqyG8TLxllJN18kVJOMyDmEd2I\nO99zOPifTdbktvyA8DhOLc4gnNuFfZxlxpXDdi+0yi5uhDlAvrPXZl1qjmNGquVU\nXbsz3ltHAgMBAAECggEAMsXl9zNxCQbi5O4U9Ajb3Wp++OJXcmKDnUiHrwaEa/el\ngoZYoz55vY0Yp+gpUIJrUeeexc60u4FcTnUXdv7oKBCzgHmiJ74i/GVsB5YPXPK6\nLLI4AYowsE2jDZrqdSdE5saLRVPJUtGkKaJhMxwBdazkXbPkmf9T1olHDcAtI50d\nY2QNNlI4K5ghqVD4h3Kho/97wyn6rD2GhnblxeA2LHUY6fA+qGY1jbOPM9f1NdPU\n9XAxj5oMcCamT87GU9s1gk3eRL1MbPX/6mei4AB9fAOw1/lJoRfy1mtc8AMgDHkH\ny+A/6eI3VNGX0ECbedtXDtSmc5BBsAWB2GOGNcOElQKBgQD1lz/1tsU7dhxEKBer\ngo6/Bnfp7lseiw7SOKqNjr7M9+UOTUcEptUYGMfAEltc6+2cj6ZvZ94wjE+EyOix\nx/RbeHS8RyBMahKKtuasO/D64E4qAyqX2uneQTC1R8DR+SO7fOu34dyb647T2PJu\nBIcKpF5kihloy089I2nKgGPk6wKBgQC9gx7QXsPpFVlJuvi8xqkdC63IzI/g7QEj\nZQWjuLXPm7dOhacw1Zla8xf9SEF8xAl4auI2f1NDrsbRNGs7JaI7fFGsXRYvQ6+j\n8AUZQsYHmZg4pTvjfFsg/7unNANRwzi7ckALuOjRi77PcTCkk0FOaAL3wwZp1jV7\nHK/0SrC8FQKBgGYzqDlP8yo4j7DJYnhMX60dOv/N4nuGcQeI72jzc3GG4/qcrCZC\na0GY5l+HBCBaSkqx+Rg5iFx5t4nRtgxt4sHCEgpcKxPBvK+fR8V7OGCewch4Atyp\nDFQimuuFzbdTz8vxQ4MFajI0x/5fNRwVpEEIgAOk+MgEe5g8yYStA2U7AoGBAKO6\nIGkNNlytIRLeAf+18m0xpdaRRMyidhVKNfEYp5rRgTDJr4Q1ReSZmOQuBMXx5+yt\nCvriTeFvoj0j+HCFNwAFi9pKIdx7sccEmqMUWVo/jI+D0ZXb3i9IQatW+HcvHlhz\ngHmgKyS+gv9dXxUQU5+VpNrBF01gz5upUSrRTJdxAoGAWESQSvgsyXpZCxOD+oEu\npK4VvMCJwMLi65HS6/w2CtE+NGh7H8ucStHC11kwiWO/pxxGj9FZG2wyrE7x0OM3\n4XzqeUIQ24u71XODRYPEILQQ372onBWo4TrvRo3FdbdilnNKuiCQAG5ZQxPkWqCn\nDg39FC1dN+D30eySOhgbEoQ=\n-----END PRIVATE KEY-----\n",
        "client_email": "sipades@swift-height-432208-b3.iam.gserviceaccount.com",
        "client_id": "101651181460493147098",
        "type": "service_account",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sipades%40swift-height-432208-b3.iam.gserviceaccount.com"
      }
    ''');
    final authClient = await clientViaServiceAccount(credentials, scopes); // Membuat client untuk autentikasi
    _sheetsApi = sheets.SheetsApi(authClient); // Inisialisasi SheetsApi
  }

  // Fungsi untuk menghasilkan ID unik untuk setiap permintaan
  String _generateUniqueID() {
    final random = Random();
    return 'PW-' + List.generate(12, (_) => random.nextInt(10)).join(); // ID diawali 'PW-' diikuti 12 digit angka acak
  }

  // Fungsi untuk memeriksa apakah NIK dan KK sudah terdaftar di spreadsheet
  Future<bool> isNIKKKRegistered(String nik, String kk) async {
    await _initializeSheetsApi(); // Pastikan SheetsApi sudah diinisialisasi
    final range = 'USERS!B2:C'; // Rentang sel di spreadsheet yang akan diperiksa
    final response = await _sheetsApi!.spreadsheets.values.get(
      sheetId,
      range,
    );
    final values = response.values ?? []; // Ambil nilai dari spreadsheet, default kosong jika null

    bool isNIKRegistered = false;
    bool isKKRegistered = false;

    // Cek setiap baris untuk melihat apakah NIK dan KK terdaftar
    for (var row in values) {
      if (row.isNotEmpty) {
        if (row[0] == nik) {
          isNIKRegistered = true;
        }
        if (row[1] == kk) {
          isKKRegistered = true;
        }
      }
    }

    return isNIKRegistered && isKKRegistered; // Kembalikan true jika keduanya terdaftar
  }

  // Fungsi untuk mengambil data pengguna dari spreadsheet
  Future<List<Map<String, dynamic>>> fetchUserData(String range) async {
    await _initializeSheetsApi(); // Pastikan SheetsApi sudah diinisialisasi
    final response = await _sheetsApi!.spreadsheets.values.get(
      sheetId,
      range,
    );
    final values = response.values ?? []; // Ambil nilai dari spreadsheet, default kosong jika null
    return values.map((row) {
      return {
        'NIK': row[0], // Ambil NIK dari baris
        'KK': row[1], // Ambil KK dari baris
      };
    }).toList();
  }

  // Fungsi untuk mencatat permintaan ke dalam spreadsheet
  Future<void> recordRequest(String sheetName, Map<String, dynamic> request) async {
    await _initializeSheetsApi(); // Pastikan SheetsApi sudah diinisialisasi

    final uniqueId = _generateUniqueID(); // Generate ID unik untuk permintaan

    // Data yang akan dicatat di spreadsheet
    final values = [
      [
        uniqueId,
        request['NIK'],
        request['KK'],
        request['EMAIL'],
        request['NOMOR TELEPON'],
        request['JENIS PERUBAHAN'],
      ]
    ];
    final valueRange = sheets.ValueRange(
      range: sheetName, // Nama sheet tempat data akan dicatat
      values: values,
    );
    // Menambahkan data ke sheet yang ditentukan
    await _sheetsApi!.spreadsheets.values.append(
      valueRange,
      sheetId,
      sheetName,
      valueInputOption: 'RAW',
    );
  }
}
