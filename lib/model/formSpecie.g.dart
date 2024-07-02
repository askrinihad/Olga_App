// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formSpecie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormSpecieAdapter extends TypeAdapter<FormSpecie> {
  @override
  final int typeId = 7;

  @override
  FormSpecie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormSpecie(
      id: fields[0] == null ? 0 : fields[0] as int,
      formWild: (fields[1] as Map).cast<String, dynamic>(),
      formPlant: (fields[2] as Map).cast<String, dynamic>(),
      formInsect: (fields[3] as Map).cast<String, dynamic>(),
      inventoryCode: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FormSpecie obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.formWild)
      ..writeByte(2)
      ..write(obj.formPlant)
      ..writeByte(3)
      ..write(obj.formInsect)
      ..writeByte(4)
      ..write(obj.inventoryCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormSpecieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
