// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipo_jogador.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TipoJogadorAdapter extends TypeAdapter<TipoJogador> {
  @override
  final int typeId = 1;

  @override
  TipoJogador read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TipoJogador.linha;
      case 1:
        return TipoJogador.goleiro;
      default:
        return TipoJogador.linha;
    }
  }

  @override
  void write(BinaryWriter writer, TipoJogador obj) {
    switch (obj) {
      case TipoJogador.linha:
        writer.writeByte(0);
        break;
      case TipoJogador.goleiro:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipoJogadorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
