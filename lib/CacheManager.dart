import 'dart:async'; // Untuk penggunaan Future dan async
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; // Untuk mengelola cache dengan Flutter Cache Manager

// Kelas ini digunakan untuk mengelola cache aplikasi
class CacheManager {
  // Fungsi statis untuk membersihkan cache
  static Future<void> clearCache() async {
    final cacheManager = DefaultCacheManager(); // Membuat instance DefaultCacheManager
    await cacheManager.emptyCache(); // Menghapus semua cache yang ada
  }
}
