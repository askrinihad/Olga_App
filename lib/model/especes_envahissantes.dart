import 'package:hive/hive.dart';

part 'especes_envahissantes.g.dart';

@HiveType(typeId:0)
class especes_envahissantes extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int  id;
  @HiveField(1)
  final String NomValide;
  @HiveField(2)
  final String NomFrancais;
  @HiveField(3)
  final String Regne;
  @HiveField(4)
  final String Classe;
  @HiveField(5)
  final String Ordre;
  @HiveField(6)
  final String Famille;
  especes_envahissantes({required this.id, required this.NomValide, required this.NomFrancais, required this.Regne, required this.Classe, required this.Ordre, required this.Famille});
}
