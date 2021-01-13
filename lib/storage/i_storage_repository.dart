

abstract class IStorageRepository{

  Future<String> read(String key);
  Future<void> upsert(String key, String value);
  Future<void> delete(String key);

}