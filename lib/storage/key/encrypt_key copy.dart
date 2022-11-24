import 'dart:convert';

import 'package:flutter_hive_encrypt/storage/key/local_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class EncryptKey extends LocalKey {
  @override
  Future<List<int>> getKey() async {
    const secureStorage = FlutterSecureStorage();
    final existKey = await secureStorage.containsKey(key: 'encrypt_key');
    if(!existKey){
      final generateKey = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64Encode(generateKey),
      );
    }
    final key = await secureStorage.read(key: 'key');
    final encryptKey = base64Url.decode(key!);
    return encryptKey;
  }
}