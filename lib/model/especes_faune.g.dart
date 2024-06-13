// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especes_faune.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class especesfauneAdapter extends TypeAdapter<especes_faune> {
  @override
  final int typeId = 2;

  @override
  especes_faune read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return especes_faune(
      id: fields[0] == null ? 0 : fields[0] as int,
      Classe: fields[1] as String,
      Famille: fields[2] as String,
      Genre: fields[3] as String,
      NomScientifique: fields[4] as String,
      Groupe_Grand_Public: fields[5] as String,
      Ordre: fields[6] as String,
      Regne: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, especes_faune obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.Classe)
      ..writeByte(2)
      ..write(obj.Famille)
      ..writeByte(3)
      ..write(obj.Genre)
      ..writeByte(4)
      ..write(obj.NomScientifique)
      ..writeByte(5)
      ..write(obj.Groupe_Grand_Public)
      ..writeByte(6)
      ..write(obj.Ordre)
      ..writeByte(7)
      ..write(obj.Regne);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is especesfauneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
