import 'package:hive/hive.dart';

part 'especes_faune.g.dart';

@HiveType(typeId:2)
class especes_faune extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int  id;

  @HiveField(1)
  final String Classe;

  @HiveField(2)
  final String Famille;

  @HiveField(3)
  final String Genre;

  @HiveField(4)
  final String NomScientifique;

  @HiveField(5)
  final String Groupe_Grand_Public;

  @HiveField(6)
  final String Ordre;

  @HiveField(7)
  final String Regne;

  especes_faune({required this.id, required this.Classe, required this.Famille, required this.Genre, required this.NomScientifique, required this.Groupe_Grand_Public, required this.Ordre, required this.Regne});

}
