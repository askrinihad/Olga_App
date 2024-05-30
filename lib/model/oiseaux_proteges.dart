import 'package:hive/hive.dart';

part 'oiseaux_proteges.g.dart';

@HiveType(typeId:1)
class oiseaux_proteges extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int  id;
  @HiveField(1)
  final String Nom;
  @HiveField(2)
  final String NomFrancais;
  @HiveField(3)
  final String NomValide;
  oiseaux_proteges({required this.id, required this.Nom, required this.NomFrancais, required this.NomValide});
}
