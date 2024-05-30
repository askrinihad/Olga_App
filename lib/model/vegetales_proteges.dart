import 'package:hive/hive.dart';

part 'vegetales_proteges.g.dart';

@HiveType(typeId:2)
class vegetales_proteges extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int  id;
  @HiveField(1)
  final String NomScientifique;
  @HiveField(2)
  final String NomFrancais;
  @HiveField(3)
  final String NomValide;
  vegetales_proteges({required this.id, required this.NomScientifique, required this.NomFrancais, required this.NomValide});
}
