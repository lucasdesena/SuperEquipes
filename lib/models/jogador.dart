// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';

part 'jogador.g.dart';

@HiveType(typeId: 0)
///Classe que representa um jogador.
class Jogador extends Equatable with HiveObjectMixin {
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
  
  @override
  List<Object?> get props => [nome, tipo, qualidade];
}
