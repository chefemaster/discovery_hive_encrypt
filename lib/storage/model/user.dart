import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String? username;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? token;

  dynamic toJson() =>
      {'username': username, 'password': password, 'token': token};
  @override
  String toString() {
    return toJson().toString();
  }
}
