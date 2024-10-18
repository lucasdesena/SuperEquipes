import 'package:hive/hive.dart';
import 'package:super_equipes/models/jogador.dart';
import 'package:super_equipes/models/resultado.dart';

class JogadorRepository{
  final Box _jogadoresBox;

  ///Construtor que inicializa o box.
  JogadorRepository() : _jogadoresBox = Hive.box<Jogador>('jogadores');

  ///Salva o jogador no banco.
  Future<Resultado<bool>> registrarJogador(Jogador jogador) async {
    try {
      await _jogadoresBox.add(jogador);
      return Sucesso(true);
    } catch (_) {
      return Erro('Erro ao salvar o jogador.');
    }
  }

  ///Busca os jogadores no banco.
  Future<Resultado<List<Jogador>>> buscarJogadores() async {
    try {
      return Sucesso(_jogadoresBox.values.toList() as List<Jogador>);
    } catch (_) {
      return Erro('Erro ao buscar os jogadores.');
    }
  }

  ///Edita o jogador no banco.
  Future<Resultado<bool>> editarJogador(int index, Jogador jogadorAtualizado) async {
    try {
      await _jogadoresBox.putAt(index, jogadorAtualizado);
      return Sucesso(true);
    } catch (_) {
      return Erro('Erro ao editar o jogador.');
    }
  }

  ///Exclui o jogador no banco.
  Future<Resultado<bool>> excluirJogador(int index) async {
    try {
      await _jogadoresBox.deleteAt(index);
      return Sucesso(true);
    } catch (_) {
      return Erro('Erro ao excluir o jogador.');
    }
  }
}