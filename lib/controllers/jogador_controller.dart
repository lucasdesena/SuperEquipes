import 'package:get/get.dart';
import 'package:super_equipes/models/jogador.dart';
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

  ///Método para salvar no controller o jogador selecionado
  void selecionarJogador(Jogador jogador) => _jogadorSelecionado = jogador;

  ///Método para registrar um jogador.
  Future<String> registrarJogador(Jogador jogador) async{
    _loading.value = true;
    String mensagemErro = '';

    bool resultado = await repositorio.registrarJogador(jogador);

    if(!resultado) mensagemErro = 'Erro ao salvar o jogador.';

    _loading.value = false;
    return mensagemErro;
  }

  ///Método para buscar os jogadores.
  Future<String> buscarJogadores() async{
    _loading.value = true;
    String mensagemErro = '';

    List<Jogador>? resultado = await repositorio.buscarJogadores();

    if(resultado == null){
      mensagemErro = 'Erro ao buscar os jogadores.';
    }else{
      _jogadores.assignAll(resultado);
    } 

    _loading.value = false;
    return mensagemErro;
  }

  ///Método para editar um jogador.
  Future<String> editarJogador(Jogador jogador) async{
    _loading.value = true;
    String mensagemErro = '';

    bool resultado = await repositorio.editarJogador(_jogadores.indexOf(_jogadorSelecionado!), jogador);

    if(!resultado) mensagemErro = 'Erro ao editar o jogador.';

    _loading.value = false;
    return mensagemErro;
  }

  ///Método para excluir um jogador.
  Future<String> excluirJogador() async{
    _loading.value = true;
    String mensagemErro = '';

    bool resultado = await repositorio.excluirJogador(_jogadores.indexOf(_jogadorSelecionado!));
    if(!resultado) mensagemErro = 'Erro ao excluir o jogador.';

    _loading.value = false;
    return mensagemErro;
  }
}
