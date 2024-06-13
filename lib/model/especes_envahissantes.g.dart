// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especes_envahissantes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class especesenvahissantesAdapter extends TypeAdapter<especes_envahissantes> {
  @override
  final int typeId = 0;

  @override
  especes_envahissantes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return especes_envahissantes(
      id: fields[0] == null ? 0 : fields[0] as int,
      NomValide: fields[1] as String,
      NomFrancais: fields[2] as String,
      Regne: fields[3] as String,
      Classe: fields[4] as String,
      Ordre: fields[5] as String,
      Famille: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, especes_envahissantes obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.NomValide)
      ..writeByte(2)
      ..write(obj.NomFrancais)
      ..writeByte(3)
      ..write(obj.Regne)
      ..writeByte(4)
      ..write(obj.Classe)
      ..writeByte(5)
      ..write(obj.Ordre)
      ..writeByte(6)
      ..write(obj.Famille);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is especesenvahissantesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
