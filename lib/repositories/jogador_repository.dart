import 'package:hive/hive.dart';
import 'package:super_equipes/models/jogador.dart';

class JogadorRepository{
  final Box _jogadoresBox;

  ///Construtor que inicializa o box.
  JogadorRepository() : _jogadoresBox = Hive.box<Jogador>('jogadores');

  ///Salva o jogador no banco.
  Future<bool> registrarJogador(Jogador jogador) async {
    try {
      await _jogadoresBox.add(jogador);
      return true;
    } catch (_) {
      return false;
    }
  }

  ///Busca os jogadores no banco.
  Future<List<Jogador>?> buscarJogadores() async {
    try {
      return _jogadoresBox.values.toList() as List<Jogador>;
    } catch (_) {
      return null;
    }
  }

  ///Edita o jogador no banco.
  Future<bool> editarJogador(int index, Jogador jogadorAtualizado) async {
    try {
      await _jogadoresBox.putAt(index, jogadorAtualizado);
      return true;
    } catch (_) {
      return false;
    }
  }

  ///Exclui o jogador no banco.
  Future<bool> excluirJogador(int index) async {
    try {
      await _jogadoresBox.deleteAt(index);
      return true;
    } catch (_) {
      return false;
    }
  }
}