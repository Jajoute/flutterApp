import 'package:flutter_projet/storage/i_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorageRepository implements IStorageRepository{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> delete(String key) async => await _prefs..remove(key);

  @override
  Future<String> read(String key) async {
    final v = await _prefs;
    return v.get(key);
  }

  @override
  Future<void> upsert(String key, String value) async=> await _prefs..setString(key, value);

}