import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'adapter/user.dart';

class Storage {
  final _secureStorage = const FlutterSecureStorage();
  late LazyBox encryptBox;

  Storage() {
    _startStorage();
  }

  Future<List<int>> _getKey() async {
    final existKey = await _secureStorage.containsKey(key: 'key');
    if (!existKey) {
      final generateKey = Hive.generateSecureKey();
      await _secureStorage.write(
        key: 'key',
        value: base64Encode(generateKey),
      );
    }
    final key = await _secureStorage.read(key: 'key');
    final encryptKey = base64Url.decode(key!);
    return encryptKey;
  }

  Future<void> _startStorage() async {
    Hive.registerAdapter(UserAdapter());
    var secretKey = await _getKey();
    encryptBox = await Hive.openLazyBox<User>(
      'storage_encrypt',
      //encryptionCipher: HiveAesCipher(secretKey),
    );
  }

  Future<void> write(String key, User user) {
    return encryptBox.put(key, user);
  }

  Future<User?> read(String key) async {
    if (!encryptBox.containsKey(key)) return null;
    return (await encryptBox.get(key)) as User;
  }
}
