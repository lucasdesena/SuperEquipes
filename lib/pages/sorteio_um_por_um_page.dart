import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:super_equipes/base/widgets/box_dropdown.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/base/widgets/box_icon.dart';
import 'package:super_equipes/base/widgets/box_snack_bar.dart.dart';
import 'package:super_equipes/controllers/jogador_controller.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/styles.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_padding.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

class SorteioUmPorUmPage extends StatefulWidget {
  const SorteioUmPorUmPage({super.key});

  @override
  State<SorteioUmPorUmPage> createState() => _SorteioPadraoPageState();
}

class _SorteioPadraoPageState extends State<SorteioUmPorUmPage> {
  final JogadorController _jogadorController = Get.find<JogadorController>();

  final List<int> opcoesQtdTimes = List.generate(5, (index) => index + 2);
  int _quantidadeTimes = 2;

  final List<int> opcoesQtd = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  late int _jogadoresPorTime;

  late List<Color> _coresSelecionadasTimes;

  late List<List<int>> _timesFormados;

  @override
  void initState() {
    _jogadoresPorTime = opcoesQtd[0];
    _coresSelecionadasTimes = List.generate(_quantidadeTimes, (index) => Get.theme.colorScheme.coresTimes[index]);
    _timesFormados = List.generate(_quantidadeTimes, (index) => List<int>.empty(growable: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: UIText.title('Sorteio um por um'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UIPadding(
                  useHorizontalPadding: true,
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: BoxDropdown(
                                enabled: !_jogadorController.comecouSorteio,
                                label: 'Número de times:',
                                initialValue: _quantidadeTimes,
                                onChanged: (quantidade) {
                                  setState(() {
                                    _quantidadeTimes = quantidade;
                                    _coresSelecionadasTimes = List.generate(
                                      _quantidadeTimes,
                                      (index) => Get.theme.colorScheme.coresTimes[index],
                                    );
                                    _timesFormados = List.generate(_quantidadeTimes, (index) => List<int>.empty(growable: true));
                                  });
                                },
                                items: opcoesQtdTimes.map(
                                  (quantidade) => DropdownMenuItem(
                                    value: quantidade,
                                    child: UIText.textField('$quantidade times'),
                                  ),
                                ).toList(),
                              ),
                            ),
                            SizedBox(width: 10.s),
                            Expanded(
                              child: BoxDropdown(
                                enabled: !_jogadorController.comecouSorteio,
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
                            ),
                          ],
                        ),
                        SizedBox(height: 10.s),
                        UIText.subtitle('Cores dos times:'),
                        SizedBox(height: 10.s),
                        SizedBox(
                          height: 35.s2,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _quantidadeTimes,
                            separatorBuilder: (context, index) => SizedBox(width: 10.s),
                            itemBuilder: (context, numeroTime) {
                              return GestureDetector(
                                onTap: _jogadorController.comecouSorteio || _quantidadeTimes == 6 ? null : () => _exibirModalTrocaCores(numeroTime),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35.s2,
                                  width: 35.s2,
                                  decoration: BoxDecoration(
                                    color: _coresSelecionadasTimes[numeroTime],
                                    shape: BoxShape.circle,
                                  ),
                                  child: UIText.numeroTime('${numeroTime + 1}'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.s),
                _buildBody(),
              ],
            ),
          ),
          floatingActionButton: Obx(() => BoxFloatingActionButton(
            label: _jogadorController.comecouSorteio ? 'Encerrar' : 'Iniciar', 
            iconData: _jogadorController.comecouSorteio ? Icons.stop : Icons.play_arrow,
            onPressed: () {
              if(_jogadorController.comecouSorteio){
                _jogadorController.encerrarSorteio();
                _timesFormados = List.generate(_quantidadeTimes, (index) => List.empty(growable: true));
              }else{
                 _jogadorController.comecarSorteio();
              }
            }, 
            extended: true,
          )),
        );
      },
    );
  }

  @override
  void dispose() {
    _jogadorController.encerrarSorteio();
    super.dispose();
  }

  ///Método que constrói o corpo da página para sortear o time de cada jogador.
  Widget _buildBody() {
    return Obx(() {
      return Column(
        children: [
          SizedBox(height: 10.s),
          GestureDetector(
            onTap: _jogadorController.comecouSorteio? () => _sortearTimes() : null,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Lottie.asset(
                  'assets/lotties/time_lottie.json',
                  width: 300.s2,
                ),
                Visibility(
                  visible: _jogadorController.comecouSorteio && _numeroJogadoresSorteados != _jogadoresPorTime * _quantidadeTimes,
                  child: Lottie.asset(
                    'assets/lotties/tap_lottie.json',
                    width: 100.s2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.s),
          Visibility(
            visible: _jogadorController.comecouSorteio,
            child: UIText.subtitle('$_numeroJogadoresSorteados/${_jogadoresPorTime * _quantidadeTimes} jogadores sorteados'),
          ),
          SizedBox(height: 10.s),
        ],
      );
    });
  }

  ///Método para exibir o modal de troca de cores.
  Future<void> _exibirModalTrocaCores(int numeroTime) async {
    final List<Color> coresDisponiveis = _getCoresDisponiveis(_coresSelecionadasTimes);
    await showGeneralDialog<Color>(
      context: context,
      barrierLabel: 'Barrier',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) {
        return ScaffoldMessenger(
          child: Builder(
            builder: (newContext) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pop(newContext),
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20.s),
                          height: 170.s,
                          width: 300.s2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.s),
                            color: Get.theme.colorScheme.surface,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  UIText.title2('Escolha a cor do time:'),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const BoxIcon(iconData: Icons.close),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.s),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(coresDisponiveis.length, (index) {
                                    return InkWell(
                                      onTap: () => Navigator.pop(newContext, coresDisponiveis[index]),
                                      child: Container(
                                        height: 50.s2,
                                        width: 50.s2,
                                        decoration: BoxDecoration(
                                          color: coresDisponiveis[index],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    ).then((Color? corSelecionada) {
      if (corSelecionada != null) {
        setState(() => _coresSelecionadasTimes[numeroTime] = corSelecionada);
      }
    });
  }

  ///Método para obter as cores disponíveis para seleção.
  List<Color> _getCoresDisponiveis(List<Color> coresSelecionadas) {
    return Get.theme.colorScheme.coresTimes.where((cor) => !coresSelecionadas.contains(cor)).toList();
  }

  ///Método para sortear os times e apresentar no BottomSheet.
  void _sortearTimes() {
    if (_numeroJogadoresSorteados == _jogadoresPorTime * _quantidadeTimes) {
      return showSnackBar(context, const BoxSnackBar.informacao(mensagem: 'Todos os jogadores já foram sorteados.'));
    }

    ///Lista com os números dos times que ainda não estão cheios
    ///(onde o número de jogadores é menor do que o número de jogadores por time, definido no DropDown).
    final List<int> timesDisponiveis = List.generate(_quantidadeTimes, (index) => index).where((time) {
      return _timesFormados[time].length < _jogadoresPorTime;
    }).toList();

    int timeSorteado = timesDisponiveis[Random().nextInt(timesDisponiveis.length)];

    setState(() => _timesFormados[timeSorteado].add(0));
    _exibirTimeSorteado(timeSorteado);
  }

  Future<void> _exibirTimeSorteado(int time) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                color: _coresSelecionadasTimes[time],
                child: UIText.titleTimeSorteado('Time ${time + 1}'),
              ),
              Positioned(
                bottom: 40.s,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(7.s),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Get.theme.colorScheme.surface, width: 2.s),
                    ),
                    child: BoxIcon(
                      iconData: Icons.close,
                      size: 24.s,
                      color: Get.theme.colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///Necessário para retornar a quantidade de jogadores já sorteados.
  int get _numeroJogadoresSorteados => _timesFormados.fold<int>(0, (total, novo) => total + novo.length);
}
