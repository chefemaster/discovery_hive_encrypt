import 'dart:convert';

import 'package:flutter_hive_encrypt/storage/core/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

abstract class LocalKey {
  Future<List<int>> getKey();
}