import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_dropdown.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/base/widgets/box_snack_bar.dart.dart';
import 'package:super_equipes/controllers/jogador_controller.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_padding.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';
import 'package:super_equipes/models/jogador.dart';
import 'package:super_equipes/models/time.dart';
import 'package:super_equipes/pages/widgets/box_card_jogador.dart';

class SorteioPadraoPage extends StatefulWidget {
  const SorteioPadraoPage({super.key});

  @override
  State<SorteioPadraoPage> createState() => _SorteioPadraoPageState();
}

class _SorteioPadraoPageState extends State<SorteioPadraoPage> {
  final JogadorController _jogadorController = Get.find<JogadorController>();
  
  final List<int> opcoesQtd = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  late int jogadoresPorTime;
  List<Jogador> jogadoresSelecionados = [];
  late List<bool> jogadoresMarcados;

  @override
  void initState() {
    jogadoresPorTime = opcoesQtd[0];
    jogadoresMarcados = List.generate(_jogadorController.jogadores.length, (_) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: UIText.title('Sorteio padrão'),
          ),
          body: Column(
            children: [
              UIPadding(
                useHorizontalPadding: true,
                child: Column(
                  children: [
                    SizedBox(height: 10.s),
                    BoxDropdown(
                      label: 'Jogadores por time:',
                      onChanged: (value) => jogadoresPorTime = value,
                      initialValue: 2,
                      items: opcoesQtd.map(
                        (quantidade) => DropdownMenuItem(
                          value: quantidade,
                          child: UIText.textField('$quantidade jogadores'),
                        ),
                      ).toList(),
                    ),          
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(tipo: 2), 
                    crossAxisSpacing: 4, 
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _jogadorController.jogadores.length,
                  itemBuilder: (context, index) {
                    final Jogador jogador = _jogadorController.jogadores[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          jogadoresMarcados[index] = !jogadoresMarcados[index];
                          if(jogadoresSelecionados.contains(jogador)){
                            jogadoresSelecionados.remove(jogador);
                          }else{
                            jogadoresSelecionados.add(jogador);
                          }
                        });
                      },
                      child: Container(
                        color: jogadoresMarcados[index] ? Theme.of(context).colorScheme.inversePrimary : null,
                        child: BoxCardJogador(
                          nome: jogador.nome,
                          qualidade: jogador.qualidade,
                          tipoJogador: jogador.tipo,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: BoxFloatingActionButton(
            label: 'Sortear', 
            iconData: Icons.casino,
            onPressed: () async => await _sortearTimes(), 
            extended: true,
          ),
        );
      },
    );
  }

  ///Método para equilibrar os times pela qualidade dos jogadores.
  void _equilibrarTimes(List<Time> times, List<Jogador> jogadoresTime){
    ///Trocar jogadores para equilibrar os times.
    bool timesEquilibrados = false;
    while (!timesEquilibrados) {
      ///Filtrar times vazios (ignorar times sem jogadores).
      List<Time> timesComJogadores = times.where((time) => time.jogadores.isNotEmpty).toList();

      ///Ordenar os times pelo total de qualidade (do menor para o maior).
      timesComJogadores.sort((a, b) => a.somaQualidades().compareTo(b.somaQualidades()));

      Time timeComMenorQualidade = timesComJogadores.first;
      Time timeComMaiorQualidade = timesComJogadores.last;

      int qualidadeMenor = timeComMenorQualidade.somaQualidades();
      int qualidadeMaior = timeComMaiorQualidade.somaQualidades();

      ///Se a diferença de qualidade entre o time com maior e menor qualidade for aceitável, encerra o loop.
      if (qualidadeMaior - qualidadeMenor <= 4) {
        timesEquilibrados = true;
        break;
      }

      ///Encontra os melhores jogadores no time com maior qualidade e os piores no time com menor qualidade.
      Jogador melhorJogadorDoTimeMaior = timeComMaiorQualidade.jogadores.reduce((a, b) => a.qualidade > b.qualidade ? a : b);
      Jogador piorJogadorDoTimeMenor = timeComMenorQualidade.jogadores.reduce((a, b) => a.qualidade < b.qualidade ? a : b);

      ///Troca os jogadores para equilibrar.
      timeComMaiorQualidade.jogadores.remove(melhorJogadorDoTimeMaior);
      timeComMenorQualidade.adicionarJogador(melhorJogadorDoTimeMaior);

      timeComMenorQualidade.jogadores.remove(piorJogadorDoTimeMenor);
      timeComMaiorQualidade.adicionarJogador(piorJogadorDoTimeMenor);
    }

    ///Após equilibrar, adiciona os jogadores restantes no time vazio (se houver).
    if (jogadoresTime.isNotEmpty) {
      Time timeVazio = times.firstWhere((time) => time.jogadores.isEmpty);
      timeVazio.jogadores.addAll(jogadoresTime);
    }
  }

  ///Método para distribuir os goleiros caso haja necessidade.
  void _ajustarGoleiros(List<Time> times){
    ///Verificar goleiros e trocar se necessário.
    bool temTimeSemGoleiro() => times.any((time) => !time.temGoleiro());
    
    for (var time in times) {
      List<Jogador> goleiros = time.jogadores.where((jogador) => jogador.tipo == TipoJogador.goleiro).toList();
      
      ///Se o time tem mais de um goleiro e há algum time sem goleiro.
      if (goleiros.length > 1 && temTimeSemGoleiro()) {
        Time timeSemGoleiro = times.firstWhere((time) => !time.temGoleiro());
        Jogador goleiroParaTrocar = goleiros.first; // Pegamos o primeiro goleiro disponível.

        ///Encontrar jogador de linha com qualidade próxima
        Jogador jogadorDeLinha = timeSemGoleiro.jogadores
            .where((jogador) => jogador.tipo != TipoJogador.goleiro)
            .reduce((a, b) => (a.qualidade - goleiroParaTrocar.qualidade).abs() < (b.qualidade - goleiroParaTrocar.qualidade).abs() ? a : b);

        ///Trocar o goleiro com o jogador de linha do time sem goleiro
        time.jogadores.remove(goleiroParaTrocar);
        timeSemGoleiro.adicionarJogador(goleiroParaTrocar);

        timeSemGoleiro.jogadores.remove(jogadorDeLinha);
        time.adicionarJogador(jogadorDeLinha);
      }
    }
  }

  ///Método para sortear os times e apresentar no BottomSheet.
  Future<void> _sortearTimes() async {
    late int qtdTimes;
    bool divisaoExata = jogadoresSelecionados.length % jogadoresPorTime == 0;

    if (divisaoExata) {
      qtdTimes = jogadoresSelecionados.length ~/ jogadoresPorTime;
    } else {
      qtdTimes = (jogadoresSelecionados.length ~/ jogadoresPorTime) + 1;
    }

    List<Jogador> jogadoresTime = List.from(jogadoresSelecionados);
    
    jogadoresTime.shuffle();

    List<Time> times = List.generate(qtdTimes, (index) => Time());

    for (var i = 0; i < (divisaoExata ? times.length : times.length - 1); i++) {
      for (var j = 0; j < jogadoresPorTime; j++) {
        times[i].adicionarJogador(jogadoresTime[j]);
      }
      for (var k = 0; k < jogadoresPorTime; k++) {
        jogadoresTime.remove(jogadoresTime[0]);
      }
    }

    _equilibrarTimes(times, jogadoresTime);

    _ajustarGoleiros(times);

    await showModalBottomSheet(
      isDismissible: false,
      context: context, 
      builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          itemCount: times.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ColoredBox(
                  color: Colors.grey,
                  child: Text('Time ${index + 1}', style: const TextStyle(fontSize: 18)),
                ),
                for (int i = 0; i < times[index].jogadores.length; i++)
                  UIText.textField('${times[index].jogadores[i].nome} - ${times[index].jogadores[i].qualidade} - ${times[index].jogadores[i].tipo.descricao}'),
              ],
            );
          },
        );
      },
    );
  }

  ///Método para buscar os jogadores cadastrados.
  Future<void> _buscarJogadores() async {
    await _jogadorController.buscarJogadores().then((mensagemErro) {
      if (mensagemErro.isNotEmpty && mounted) return showSnackBar(context, BoxSnackBar.erro(mensagem: mensagemErro));
    });
  }
}
