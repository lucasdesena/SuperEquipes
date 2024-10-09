import 'package:hive/hive.dart';

part 'tipo_jogador.g.dart';

@HiveType(typeId: 1) 
enum TipoJogador {
  @HiveField(0)
  linha,
  @HiveField(1)
  goleiro 
}

extension TipoJogadorExtension on TipoJogador{
  String get descricao{
    switch (this) {
      case TipoJogador.linha:
        return "linha";
      case TipoJogador.goleiro:
        return "goleiro";
    }
  }
}