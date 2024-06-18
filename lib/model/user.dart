import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId:6)
class User extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String airport;

  @HiveField(4)
  final String token;

  @HiveField(5)
  final DateTime tokenExpiryDate;

  User({required this.id, required this.email, required this.password, required this.airport, required this.token, required this.tokenExpiryDate});
}