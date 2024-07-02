import 'package:hive/hive.dart';

part 'formSpecie.g.dart';

@HiveType(typeId: 7)
class FormSpecie extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1)
  final Map<String, dynamic> formWild;

  @HiveField(2)
  final Map<String, dynamic> formPlant;

  @HiveField(3)
  final Map<String, dynamic> formInsect;

  @HiveField(4)
  final String inventoryCode;

  FormSpecie({required this.id, required this.formWild, required this.formPlant, required this.formInsect, required this.inventoryCode});
}