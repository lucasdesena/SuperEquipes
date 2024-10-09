import 'package:hive/hive.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';

part 'jogador.g.dart';

@HiveType(typeId: 0)
///Classe que representa um jogador.
class Jogador extends HiveObject {
  @HiveField(0)
  String nome;
  @HiveField(1)
  TipoJogador tipo;
  @HiveField(2)
  int qualidade;

  Jogador({
    required this.nome,
    required this.tipo,
    required this.qualidade,
  });
}
