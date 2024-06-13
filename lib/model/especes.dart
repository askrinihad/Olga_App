import 'package:hive/hive.dart';
 
part 'especes.g.dart';

@HiveType(typeId: 1)
class especes_bdd extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int id;

  @HiveField(1)
  final String ScientifiqueName;

  @HiveField(2)
  final String VernacularName;

  @HiveField(3)
  final String Phylum;

  @HiveField(4)
  final String Class;

  @HiveField(5)
  final String Order;

  @HiveField(6)
  final String Family;

  @HiveField(7)
  final String Note;

  @HiveField(8)
  final String Type;

  @HiveField(9)
  final String Status;

  especes_bdd({required this.id, required this.ScientifiqueName, required this.VernacularName, required this.Phylum, required this.Class, required this.Order, required this.Family, required this.Note, required this.Type, required this.Status});
}