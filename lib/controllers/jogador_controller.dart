import 'package:get/get.dart';
import 'package:super_equipes/models/jogador.dart';
import 'package:super_equipes/models/resultado.dart';
import 'package:super_equipes/repositories/jogador_repository.dart';

///Classe que controla o tema.
class JogadorController extends GetxController {
  final JogadorRepository repositorio = JogadorRepository();

  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  
  final RxList<Jogador> _jogadores = <Jogador>[].obs;
  List<Jogador> get jogadores => _jogadores;

  Jogador? _jogadorSelecionado;
  Jogador? get jogadorSelecionado => _jogadorSelecionado;

  final RxBool _comecouSorteio = false.obs;
  bool get comecouSorteio => _comecouSorteio.value;

  ///Método para iniciar o sorteio um por um.
  void comecarSorteio() => _comecouSorteio.value = true;

  ///Método para encerrar o sorteio um por um.
  void encerrarSorteio() => _comecouSorteio.value = false;

  ///Método para salvar no controller o jogador selecionado
  void selecionarJogador(Jogador jogador) => _jogadorSelecionado = jogador;

  ///Método para registrar um jogador.
  Future<String> registrarJogador(Jogador jogador) async{
    _loading.value = true;
    String mensagemErro = '';

    Resultado resultado = await repositorio.registrarJogador(jogador);

    switch (resultado) {
      case Sucesso():
        break;
      case Erro(:String mensagem):
        mensagemErro = mensagem;
        break;
    }

    _loading.value = false;
    return mensagemErro;
  }

  ///Método para buscar os jogadores.
  Future<String> buscarJogadores() async{
    _loading.value = true;
    String mensagemErro = '';

    Resultado<List<Jogador>> resultado = await repositorio.buscarJogadores();

    switch (resultado) {
      case Sucesso(:List<Jogador> dados):
        _jogadores.assignAll(dados);
        break;
      case Erro(:String mensagem):
        mensagemErro = mensagem;
        break;
    }


    _loading.value = false;
    return mensagemErro;
  }

  ///Método para editar um jogador.
  Future<String> editarJogador(Jogador jogador) async{
    _loading.value = true;
    String mensagemErro = '';

    Resultado<bool> resultado = await repositorio.editarJogador(_jogadores.indexOf(_jogadorSelecionado!), jogador);

    switch (resultado) {
      case Sucesso():
        break;
      case Erro(:String mensagem):
        mensagemErro = mensagem;
        break;
    }

    _loading.value = false;
    return mensagemErro;
  }

  ///Método para excluir um jogador.
  Future<String> excluirJogador() async{
    _loading.value = true;
    String mensagemErro = '';

    Resultado resultado = await repositorio.excluirJogador(_jogadores.indexOf(_jogadorSelecionado!));

    switch (resultado) {
      case Sucesso():
        break;
      case Erro(:String mensagem):
        mensagemErro = mensagem;
        break;
    }

    _loading.value = false;
    return mensagemErro;
  }

}
