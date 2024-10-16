import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_alert_dialog.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/base/widgets/box_icon.dart';
import 'package:super_equipes/base/widgets/box_snack_bar.dart.dart';
import 'package:super_equipes/base/widgets/box_text_field.dart';
import 'package:super_equipes/controllers/jogador_controller.dart';
import 'package:super_equipes/core/routes.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_padding.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/core/validators.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';
import 'package:super_equipes/models/jogador.dart';
import 'package:super_equipes/base/widgets/box_card_jogador_animacao.dart';

class SobreJogadorPage extends StatefulWidget {
  const SobreJogadorPage({super.key});

  @override
  State<SobreJogadorPage> createState() => _SobreJogadorPageState();
}

class _SobreJogadorPageState extends State<SobreJogadorPage> with SingleTickerProviderStateMixin {
  final JogadorController _jogadorController = Get.find<JogadorController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlNome = TextEditingController();
  final List<String> _qualidades = ['Peréba', 'Ruim', 'Normal', 'Bom', 'Craque'];
  final List<bool> _selectedChips = [false, false, false, false, false];

  late TipoJogador _tipoSelecionado;
  late int _qualidadeAnterior;
  late int _qualidadeSelecionada;

  late AnimationController _controllerAnimacao;
  late Animation<int> _qualidadeAnimada;

  @override
  void initState() {
    super.initState();
    
    _ctrlNome.text = _jogadorController.jogadorSelecionado!.nome;
    _tipoSelecionado = _jogadorController.jogadorSelecionado!.tipo;
    _qualidadeSelecionada = _jogadorController.jogadorSelecionado!.qualidade;
    _qualidadeAnterior = _qualidadeSelecionada;
    _selectedChips[_qualidadeSelecionada - 1] = true;

    // Configuração do controlador de animação
    _controllerAnimacao = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animarQualidade();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) => _showConfirmarSaida(pop: true),
      child: OrientationBuilder(
        builder: (orientationContext, orientation) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => _showConfirmarSaida(),
                icon: const Icon(Icons.arrow_back),
              ),
              title: UIText.title('Jogador'),
              actions: [
                IconButton(
                  onPressed: () async => await _showConfirmarExclusaoJogador(),
                  icon: const BoxIcon(iconData: Icons.delete_outline_rounded),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  UIPadding(
                    useVerticalPadding: true,
                    useHorizontalPadding: true,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _ctrlNome,
                            builder: (context, controller, _) {
                              return BoxTextField(
                                enableButtonCleanValue: true,
                                label: 'Nome:',
                                controller: _ctrlNome,
                                hintText: 'Insira o nome do jogador',
                                validatorFunction: Validators.validarNome,
                              );
                            }
                          ),
                          SizedBox(height: 10.s),
                          SegmentedButton<String>(
                            selectedIcon: BoxIcon(
                              iconData: Icons.sports_soccer,
                              size: 18.s5,
                            ),
                            segments: <ButtonSegment<String>>[
                              ButtonSegment<String>(
                                value: TipoJogador.linha.descricao,
                                label: UIText.body('Linha'),
                              ),
                              ButtonSegment<String>(
                                value: TipoJogador.goleiro.descricao,
                                label: UIText.body('Goleiro'),
                              ),
                            ],
                            selected: <String>{_tipoSelecionado.descricao},
                            onSelectionChanged: (Set<String> novoValor) {
                              setState(() => _tipoSelecionado = novoValor.first == 'linha' ? TipoJogador.linha : TipoJogador.goleiro);
                            },
                          ),
                          SizedBox(height: 10.s),
                          BoxCardJogadorAnimacao(
                            nome: _ctrlNome.text,
                            qualidade: _qualidadeSelecionada,
                            qualidadeAnimada: _qualidadeAnimada,
                            tipoJogador: _tipoSelecionado,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.s,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: _qualidades.length,
                      separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.symmetric(horizontal: 4)), 
                      itemBuilder: (context, index) {
                        return ChoiceChip(
                          showCheckmark: false,
                          label: UIText.body(_qualidades[index]), 
                          selected: _selectedChips[index],
                          onSelected: (_) {
                            setState(() {
                              _qualidadeAnterior = _qualidadeSelecionada;
                              if (!_selectedChips[index]) {
                                // Marca o chip selecionado e desmarca os outros
                                for (int i = 0; i < _selectedChips.length; i++) {
                                  _selectedChips[i] = i == index;
                                  if (i == index) _qualidadeSelecionada = i + 1;
                                }
                                _animarQualidade();
                              }
                            });
                          },
                        );
                      }, 
                    ),
                  ),
                  Visibility(
                    visible: isMobile,
                    child: const SizedBox(height: 80),
                  ),
                ],
              ),
            ),
            floatingActionButton: BoxFloatingActionButton(
              extended: true,
              label: 'Editar jogador',
              iconData: Icons.edit_outlined,
              onPressed: _editarJogador,
            ),
          );
        }
      ),
    );
  }
  
  @override
  void dispose() {
    _controllerAnimacao.dispose();
    _ctrlNome.dispose();
    super.dispose();
  }

  void _showConfirmarSaida({bool pop = false}) {
    final Jogador jogadorEditado = Jogador(nome: _ctrlNome.text, tipo: _tipoSelecionado, qualidade: _qualidadeSelecionada);
    jogadorEditado != _jogadorController.jogadorSelecionado! && !pop
      ? showDialog(
          context: context,
          builder: (context) => BoxAlertDialog(
            title: 'Tem certeza?',
            content: 'Todas as alterações realizadas que não foram salvas serão desfeitas',
            actions: [
              TextButton(onPressed: () => Get.back(), child: UIText.dialogCancel('Cancelar')),
              TextButton(onPressed: () => Get.until((_) => Get.currentRoute == Routes.baseRoute), child: UIText.dialogConfirm('Confirmar'))
            ],
          ),
        )
      : Get.back();
  }

  Future<void> _showConfirmarExclusaoJogador() async {
    await showDialog(
      context: context,
      builder: (context) => BoxAlertDialog(
        title: 'Excluir jogador',
        content: 'Você quer excluir este jogador?',
        actions: [
          TextButton(onPressed: () => Get.back(), child: UIText.dialogCancel('Cancelar')),
          TextButton(onPressed: () async => await _excluirJogador(), child: UIText.dialogConfirm('Excluir'))
        ],
      ),
    );
  }

  Future<void> _excluirJogador() async {
    await _jogadorController.excluirJogador().then((mensagemErro) async {
      if (mounted) {
        if (mensagemErro.isNotEmpty) return showSnackBar(context, BoxSnackBar.erro(mensagem: mensagemErro));
        Get.offAllNamed(Routes.baseRoute);
      }
    });
  }

  Future<void> _editarJogador() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final Jogador jogadorEditado = Jogador(nome: _ctrlNome.text, tipo: _tipoSelecionado, qualidade: _qualidadeSelecionada);
      await _jogadorController.editarJogador(jogadorEditado).then((mensagemErro) {
        if (mounted) {
          if (mensagemErro.isNotEmpty) return showSnackBar(context, BoxSnackBar.erro(mensagem: mensagemErro));
          showSnackBar(context, const BoxSnackBar.successo(mensagem: 'Informações alteradas com sucesso!'));
          Get.back();
        }
      });
    }
  }

  void _animarQualidade() {
    _controllerAnimacao.reset();
    _qualidadeAnimada = IntTween(
      begin: int.parse(_getQualidadeJogador(_qualidadeAnterior)),
      end: int.parse(_getQualidadeJogador(_qualidadeSelecionada)),
    ).animate(_controllerAnimacao)
      ..addListener(() => setState(() {}));
    _controllerAnimacao.forward();
  }

  String _getQualidadeJogador(int qualidadeJogador) {
    return switch (qualidadeJogador) {
      1 => '-1',
      2 => '10',
      3 => '50',
      4 => '80',
      5 => '99',
      _ => '...',
    };
  }
}
