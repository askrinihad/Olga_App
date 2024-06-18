import 'package:hive/hive.dart';

part 'observation.g.dart';

@HiveType(typeId: 5)
class Observation extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1)
  final Map<String, dynamic> formData;

  @HiveField(2)
  final String? type;

  @HiveField(3)
  final String? airport;

  Observation({required this.id, required this.formData, required this.type, required this.airport});
}