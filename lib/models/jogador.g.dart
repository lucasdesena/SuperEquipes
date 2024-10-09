// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jogador.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JogadorAdapter extends TypeAdapter<Jogador> {
  @override
  final int typeId = 0;

  @override
  Jogador read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Jogador(
      nome: fields[0] as String,
      tipo: fields[1] as TipoJogador,
      qualidade: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Jogador obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.tipo)
      ..writeByte(2)
      ..write(obj.qualidade);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JogadorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
