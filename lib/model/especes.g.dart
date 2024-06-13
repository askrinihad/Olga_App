// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class especesbddAdapter extends TypeAdapter<especes_bdd> {
  @override
  final int typeId = 1;

  @override
  especes_bdd read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return especes_bdd(
      id: fields[0] == null ? 0 : fields[0] as int,
      ScientifiqueName: fields[1] as String,
      VernacularName: fields[2] as String,
      Phylum: fields[3] as String,
      Class: fields[4] as String,
      Order: fields[5] as String,
      Family: fields[6] as String,
      Note: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, especes_bdd obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ScientifiqueName)
      ..writeByte(2)
      ..write(obj.VernacularName)
      ..writeByte(3)
      ..write(obj.Phylum)
      ..writeByte(4)
      ..write(obj.Class)
      ..writeByte(5)
      ..write(obj.Order)
      ..writeByte(6)
      ..write(obj.Family)
      ..writeByte(7)
      ..write(obj.Note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is especesbddAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
