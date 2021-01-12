import 'package:flutter_projet/storage/i_storage_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageRepository implements IStorageRepository{
  final storage = new FlutterSecureStorage();

  @override
  Future<void> delete(String key) async => await storage.delete(key: key);

  @override
  Future<String> read(String key) async=> await storage.read(key: key);

  @override
  Future<void> upsert(String key, String value) async=> await storage.write(key: key, value: value);
}