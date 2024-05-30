// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oiseaux_proteges.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class oiseauxprotegesAdapter extends TypeAdapter<oiseaux_proteges> {
  @override
  final int typeId = 1;

  @override
  oiseaux_proteges read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return oiseaux_proteges(
      id: fields[0] == null ? 0 : fields[0] as int,
      Nom: fields[1] as String,
      NomFrancais: fields[2] as String,
      NomValide: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, oiseaux_proteges obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.Nom)
      ..writeByte(2)
      ..write(obj.NomFrancais)
      ..writeByte(3)
      ..write(obj.NomValide);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is oiseauxprotegesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
