import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/storage_service.dart';

part 'storage_provider.g.dart';

/// Storage Service Provider
@Riverpod(keepAlive: true)
StorageService storageService(StorageServiceRef ref) {
  return StorageService();
}

/// Storage 초기화 상태
@Riverpod(keepAlive: true)
class StorageInitialized extends _$StorageInitialized {
  @override
  Future<bool> build() async {
    final storage = ref.watch(storageServiceProvider);
    await storage.initialize();
    return true;
  }
}
