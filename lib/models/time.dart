import 'package:super_equipes/models/enum/tipo_jogador.dart';
import 'package:super_equipes/models/jogador.dart';

///Classe que representa um time.
class Time {
  final List<Jogador> jogadores = [];

  void adicionarJogador(Jogador jogador) {
    jogadores.add(jogador);
  }

  int somaQualidades() {
    return jogadores.fold(0, (total, jogador) => total + jogador.qualidade);
  }

  bool temGoleiro() {
    return jogadores.any((jogador) => jogador.tipo == TipoJogador.goleiro);
  }
}