import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 1)
class Data extends HiveObject {
  @HiveField(0)
  DateTime? birthday;
  @HiveField(1)
  int? old;
  @HiveField(2)
  bool? live;

  dynamic toJson() =>
      {'birthday': birthday!.toString(), 'old': old, 'live': live};
  @override
  String toString() {
    return toJson().toString();
  }
}
