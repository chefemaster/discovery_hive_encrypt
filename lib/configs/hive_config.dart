import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveConfig {
  static start() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final local = dir.path;
    debugPrint(local);
    await Hive.initFlutter(local);
  }
}
