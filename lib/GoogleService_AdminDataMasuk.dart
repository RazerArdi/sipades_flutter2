import 'dart:convert';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleService_AdminDataMasuk {
  final String _spreadsheetId = '145zImHcPjL-IsrVdfB_YVOFXsnnJQkGlYpAHcBv2RGI';
  final String _range = 'PermintaanSurat!A:E';
  final _credentials = r'''
  {
    "type": "service_account",
    "project_id": "swift-height-432208-b3",
    "private_key_id": "d3a0ca84f74d32aa62c97ffc024e5ff9453c4bcf",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1znQtwfhiMFMU\nxxBKKESDUQarkiZD2eYiiUwpLla2k0qd7VC/x4/EdFHzaLQ4Tv9Bl4oUijNgtyxX\n/7DyH3kmPvM9Ow48uOuimXWG+GlIDl3U8GSl8kgjgQP7lGI4A8b9LIA0WtBRufri\nchrcuGL/JQuqp2qkwPbta2/HXoRGDtHRotnIg7Od584Q+pI9RoFk2RutiR7YYz/s\nMKr6bZHdY82/8fV2O7ehlIPvcDYI2qn+oI1WunOqyG8TLxllJN18kVJOMyDmEd2I\nO99zOPifTdbktvyA8DhOLc4gnNuFfZxlxpXDdi+0yi5uhDlAvrPXZl1qjmNGquVU\nXbsz3ltHAgMBAAECggEAMsXl9zNxCQbi5O4U9Ajb3Wp++OJXcmKDnUiHrwaEa/el\ngoZYoz55vY0Yp+gpUIJrUeeexc60u4FcTnUXdv7oKBCzgHmiJ74i/GVsB5YPXPK6\nLLI4AYowsE2jDZrqdSdE5saLRVPJUtGkKaJhMxwBdazkXbPkmf9T1olHDcAtI50d\nY2QNNlI4K5ghqVD4h3Kho/97wyn6rD2GhnblxeA2LHUY6fA+qGY1jbOPM9f1NdPU\n9XAxj5oMcCamT87GU9s1gk3eRL1MbPX/6mei4AB9fAOw1/lJoRfy1mtc8AMgDHkH\ny+A/6eI3VNGX0ECbedtXDtSmc5BBsAWB2GOGNcOElQKBgQD1lz/1tsU7dhxEKBer\ngo6/Bnfp7lseiw7SOKqNjr7M9+UOTUcEptUYGMfAEltc6+2cj6ZvZ94wjE+EyOix\nx/RbeHS8RyBMahKKtuasO/D64E4qAyqX2uneQTC1R8DR+SO7fOu34dyb647T2PJu\nBIcKpF5kihloy089I2nKgGPk6wKBgQC9gx7QXsPpFVlJuvi8xqkdC63IzI/g7QEj\nZQWjuLXPm7dOhacw1Zla8xf9SEF8xAl4auI2f1NDrsbRNGs7JaI7fFGsXRYvQ6+j\n8AUZQsYHmZg4pTvjfFsg/7unNANRwzi7ckALuOjRi77PcTCkk0FOaAL3wwZp1jV7\nHK/0SrC8FQKBgGYzqDlP8yo4j7DJYnhMX60dOv/N4nuGcQeI72jzc3GG4/qcrCZC\na0GY5l+HBCBaSkqx+Rg5iFx5t4nRtgxt4sHCEgpcKxPBvK+fR8V7OGCewch4Atyp\nDFQimuuFzbdTz8vxQ4MFajI0x/5fNRwVpEEIgAOk+MgEe5g8yYStA2U7AoGBAKO6\nIGkNNlytIRLeAf+18m0xpdaRRMyidhVKNfEYp5rRgTDJr4Q1ReSZmOQuBMXx5+yt\nCvriTeFvoj0j+HCFNwAFi9pKIdx7sccEmqMUWVo/jI+D0ZXb3i9IQatW+HcvHlhz\ngHmgKyS+gv9dXxUQU5+VpNrBF01gz5upUSrRTJdxAoGAWESQSvgsyXpZCxOD+oEu\npK4VvMCJwMLi65HS6/w2CtE+NGh7H8ucStHC11kwiWO/pxxGj9FZG2wyrE7x0OM3\n4XzqeUIQ24u71XODRYPEILQQ372onBWo4TrvRo3FdbdilnNKuiCQAG5ZQxPkWqCn\nDg39FC1dN+D30eySOhgbEoQ=\n-----END PRIVATE KEY-----\n",
    "client_email": "sipades@swift-height-432208-b3.iam.gserviceaccount.com",
    "client_id": "101651181460493147098",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/sipades%40swift-height-432208-b3.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''';

  Future<List<Map<String, String>>> fetchData() async {
    final accountCredentials = ServiceAccountCredentials.fromJson(jsonDecode(_credentials));
    final scopes = [SheetsApi.spreadsheetsReadonlyScope];

    final authClient = await clientViaServiceAccount(accountCredentials, scopes);

    final sheetsApi = SheetsApi(authClient);

    final response = await sheetsApi.spreadsheets.values.get(_spreadsheetId, _range);

    final rows = response.values ?? [];
    final List<Map<String, String>> data = [];

    if (rows.isNotEmpty) {
      final headers = rows.first.map((e) => e.toString()).toList();

      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];
        final Map<String, String> rowData = {};

        for (int j = 0; j < row.length; j++) {
          rowData[headers[j]] = row[j].toString();
        }
        data.add(rowData);
      }
    }

    return data;
  }

  Future<void> updateStatus(String id, String newStatus) async {
    final accountCredentials = ServiceAccountCredentials.fromJson(jsonDecode(_credentials));
    final scopes = [SheetsApi.spreadsheetsScope];

    final authClient = await clientViaServiceAccount(accountCredentials, scopes);

    final sheetsApi = SheetsApi(authClient);

    // Determine the range for updating the status
    final response = await sheetsApi.spreadsheets.values.get(_spreadsheetId, _range);
    final rows = response.values ?? [];
    final headers = rows.isNotEmpty ? rows.first : [];

    int rowIndex = -1;
    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      final Map<String, String> rowData = {};
      for (int j = 0; j < row.length; j++) {
        rowData[headers[j]] = row[j].toString();
      }
      if (rowData['ID'] == id) {
        rowIndex = i;
        break;
      }
    }

    if (rowIndex != -1) {
      final statusColumnIndex = headers.indexOf('Status');
      final rangeToUpdate = 'PermintaanSurat!${_getCellAddress(rowIndex + 1, statusColumnIndex + 1)}';

      final updateRequest = ValueRange.fromJson({
        'range': rangeToUpdate,
        'values': [
          [newStatus]
        ]
      });

      await sheetsApi.spreadsheets.values.update(
        updateRequest,
        _spreadsheetId,
        rangeToUpdate,
        valueInputOption: 'RAW',
      );
    }
  }

  String _getCellAddress(int row, int col) {
    final columnLetter = String.fromCharCode('A'.codeUnitAt(0) + col - 1);
    return '$columnLetter$row';
  }
}
