import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:super_equipes/base/widgets/box_dropdown.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/base/widgets/box_icon.dart';
import 'package:super_equipes/base/widgets/box_lista_vazia.dart';
import 'package:super_equipes/base/widgets/box_snack_bar.dart.dart';
import 'package:super_equipes/base/widgets/box_text_field.dart';
import 'package:super_equipes/controllers/jogador_controller.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_padding.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/core/utils.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';
import 'package:super_equipes/models/jogador.dart';
import 'package:super_equipes/models/time.dart';
import 'package:super_equipes/base/widgets/box_card_jogador.dart';

class SorteioPadraoPage extends StatefulWidget {
  const SorteioPadraoPage({super.key});

  @override
  State<SorteioPadraoPage> createState() => _SorteioPadraoPageState();
}

class _SorteioPadraoPageState extends State<SorteioPadraoPage> {
  final JogadorController _jogadorController = Get.find<JogadorController>();
  final TextEditingController _ctrlBuscarJogador = TextEditingController();
  
  final List<int> opcoesQtd = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  late int _jogadoresPorTime;
  final List<Jogador> _jogadoresSelecionados = [];

  @override
  void initState() {
    _jogadoresPorTime = opcoesQtd[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const BoxIcon(
                iconData: Icons.arrow_back,
              ),
            ),
            title: Obx(
              () {
                return _jogadorController.pesquisando
                  ? BoxTextField(
                      autofocus: true,
                      controller: _ctrlBuscarJogador,
                      contentPadding: EdgeInsets.all(10.s),
                      hintText: 'Nome do jogador...',
                      onChanged: _jogadorController.pesquisarJogadores,
                    )
                  : UIText.title('Sorteio padrão'); 
              },
            ),
            actions: [
              Obx(
                () {
                  return IconButton(
                    onPressed: () {
                      if (_jogadorController.pesquisando) _ctrlBuscarJogador.clear();
                      _jogadorController.handlerPesquisa();
                      _jogadorController.pesquisarJogadores(_ctrlBuscarJogador.text);
                    },
                    icon: _jogadorController.pesquisando
                      ? const BoxIcon(iconData: Icons.close)
                      : const BoxIcon(iconData: Icons.search),
                  );
                },
              ),
            ]
          ),
          body: Obx(
            () {          
              return Visibility(
              visible: _jogadorController.jogadoresFiltrados.isNotEmpty,
              replacement: const BoxListaVazia(),
              child: Column(
                children: [
                  UIPadding(
                    useHorizontalPadding: true,
                    child: Column(
                      children: [
                        SizedBox(height: 10.s),
                        BoxDropdown(
                          label: 'Jogadores por time:',
                          onChanged: (value) => _jogadoresPorTime = value,
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
                      padding: EdgeInsets.only(top: 12.s2, bottom: 70.s2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: Device.width < 600 && orientation == Orientation.landscape ? 0.74 : 1,
                        crossAxisCount: getCrossAxisCount(tipo: 2), 
                        crossAxisSpacing: 4, 
                        mainAxisSpacing: 4,
                      ),
                      itemCount: _jogadorController.jogadoresFiltrados.length,
                      itemBuilder: (context, index) {
                        final Jogador jogador = _jogadorController.jogadoresFiltrados[index];
                          
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _jogadoresSelecionados.contains(jogador)
                                ? _jogadoresSelecionados.remove(jogador)
                                : _jogadoresSelecionados.add(jogador);
                            });
                          },
                          child: Container(
                            color: _jogadoresSelecionados.contains(jogador) ? Get.theme.colorScheme.tertiaryContainer : null,
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
            );
            },
          ),
          floatingActionButton: _jogadorController.jogadoresFiltrados.isEmpty ? null : BoxFloatingActionButton(
            label: 'Sortear times', 
            iconData: Icons.casino,
            onPressed: () async {
              if(_jogadoresSelecionados.isEmpty) return showSnackBar(context, const BoxSnackBar.informacao(mensagem: 'Você precisa selecionar os jogadores.')); 
              if(_jogadoresSelecionados.length < _jogadoresPorTime) return showSnackBar(context, const BoxSnackBar.informacao(mensagem: 'A quantidade de jogadores selecionados não é suficiente.')); 
              await _sortearTimes();
            }, 
            extended: true,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    if (_jogadorController.pesquisando) _jogadorController.handlerPesquisa();
    _ctrlBuscarJogador.clear();
    super.dispose();
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
        ///Pegamos o primeiro goleiro disponível.
        Time timeSemGoleiro = times.firstWhere((time) => !time.temGoleiro());
        Jogador goleiroParaTrocar = goleiros.first; 

        ///Encontrar jogador de linha com qualidade próxima.
        Jogador jogadorDeLinha = timeSemGoleiro.jogadores
            .where((jogador) => jogador.tipo != TipoJogador.goleiro)
            .reduce((a, b) => (a.qualidade - goleiroParaTrocar.qualidade).abs() < (b.qualidade - goleiroParaTrocar.qualidade).abs() ? a : b);

        ///Trocar o goleiro com o jogador de linha do time sem goleiro.
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
    bool divisaoExata = _jogadoresSelecionados.length % _jogadoresPorTime == 0;

    if (divisaoExata) {
      qtdTimes = _jogadoresSelecionados.length ~/ _jogadoresPorTime;
    } else {
      qtdTimes = (_jogadoresSelecionados.length ~/ _jogadoresPorTime) + 1;
    }

    List<Jogador> jogadoresTime = List.from(_jogadoresSelecionados);
    
    jogadoresTime.shuffle();

    List<Time> times = List.generate(qtdTimes, (index) => Time());

    for (var i = 0; i < (divisaoExata ? times.length : times.length - 1); i++) {
      for (var j = 0; j < _jogadoresPorTime; j++) {
        times[i].adicionarJogador(jogadoresTime[j]);
      }
      for (var k = 0; k < _jogadoresPorTime; k++) {
        jogadoresTime.remove(jogadoresTime[0]);
      }
    }

    _equilibrarTimes(times, jogadoresTime);

    _ajustarGoleiros(times);

    await _mostrarTimes(times);
  }

  Future<void> _mostrarTimes(List<Time> times) async {
    await showModalBottomSheet(
      isDismissible: false,
      context: context, 
      builder: (context) {
        return Column(
          children: [
            SizedBox(height: 10.s2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UIText.title('Times'),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const BoxIcon(
                      iconData: Icons.close,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                itemCount: times.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10.s),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: const Alignment(0.8, 1),
                        colors: [
                          Utils.corFundoCorpo(index),
                          Utils.corFundoCorpo(index + 1),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        UIText.timeTitle('Time ${index + 1}'),
                        Divider(
                          color: Get.theme.colorScheme.inverseSurface, 
                        ),
                        for (int i = 0; i < times[index].jogadores.length; i++)
                          ListTile(
                            title: UIText.textField(times[index].jogadores[i].nome),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: FadeInImage(
                                placeholder: const AssetImage('assets/images/card_padrao.png'), 
                                image: AssetImage('assets/images/card_${times[index].jogadores[i].tipo.descricao}_${times[index].jogadores[i].qualidade}.png'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  } 
}
