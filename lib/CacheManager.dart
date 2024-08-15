import 'dart:async';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManager {
  static Future<void> clearCache() async {
    final cacheManager = DefaultCacheManager();
    await cacheManager.emptyCache();
  }
}
