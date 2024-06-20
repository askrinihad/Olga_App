import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId:6)
class User extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? password;

  @HiveField(3)
  final String airport;

  @HiveField(4)
  final String? token;

  @HiveField(5)
  final DateTime? tokenExpiryDate;

  @HiveField(6)
  bool? isLogged;

  User({required this.id, required this.email, this.password, required this.airport,this.token, this.tokenExpiryDate, this.isLogged}) {
    isLogged ??= false;
  }
}