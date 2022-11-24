import 'package:flutter_hive_encrypt/storage/core/local_storage.dart';
import 'package:hive/hive.dart';

import '../key/local_key.dart';

class SecureStorage extends LocalStorage{
  late LazyBox _encryptBox;

  SecureStorage(LocalKey localKey) {
    _startStorage(localKey);
  }

  Future<void> _startStorage(LocalKey localKey) async {
    final _encryptKey = await localKey.getKey();
    _encryptBox = await Hive.openLazyBox(
      'secure_storage',
      encryptionCipher: HiveAesCipher(_encryptKey)
    );
  }

  @override
  Future<bool> contains(String key) {
    return Future(() => _encryptBox.containsKey(key));
  }

  @override
  Future<T> read<T>(String key) async {
    return (await _encryptBox.get(key)) as T;
  }

  @override
  Future<void> remove(String key) {    
    return _encryptBox.delete(key);
  }

  @override
  Future<void> write<T>(String key, T value) {
    return _encryptBox.put(key, value);
  }

}