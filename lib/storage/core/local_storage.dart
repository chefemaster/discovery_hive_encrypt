abstract class LocalStorage {
  Future<T> read<T>(String key);
  Future<void> write<T>(String key, T value);
  Future<bool> contains(String key);  
  Future<void> remove(String key);
}