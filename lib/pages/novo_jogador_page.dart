import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/base/widgets/box_snack_bar.dart.dart';
import 'package:super_equipes/base/widgets/box_text_field.dart';
import 'package:super_equipes/controllers/jogador_controller.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_padding.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/core/validators.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';
import 'package:super_equipes/models/jogador.dart';
import 'package:super_equipes/base/widgets/box_card_jogador_animacao.dart';

class NovoJogadorPage extends StatefulWidget {
  const NovoJogadorPage({super.key});

  @override
  State<NovoJogadorPage> createState() => _NovoJogadorPageState();
}

class _NovoJogadorPageState extends State<NovoJogadorPage> with SingleTickerProviderStateMixin {
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
    _qualidadeSelecionada = 1;
    _qualidadeAnterior = _qualidadeSelecionada;
    _tipoSelecionado = TipoJogador.linha;
    // Configuração do controlador de animação
    _controllerAnimacao = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animarQualidade();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: UIText.title('Novo Jogador'),
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
                          builder: (context, _, __) {
                            return BoxTextField(
                              autofocus: true,
                              controller: _ctrlNome,
                              enableButtonCleanValue: true,
                              label: 'Nome:',
                              hintText: 'Insira o nome do jogador',
                              validatorFunction: Validators.validarNome,
                            );
                          }
                        ),
                        SizedBox(height: 10.s),
                        SegmentedButton<String>(
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
                        ValueListenableBuilder(
                          valueListenable: _ctrlNome,
                          builder: (context, textEditingValue, _) {
                            return BoxCardJogadorAnimacao(
                              nome: textEditingValue.text,
                              qualidade: _qualidadeSelecionada,
                              qualidadeAnimada: _qualidadeAnimada,
                              tipoJogador: _tipoSelecionado,
                            );
                          }
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
            label: 'Cadastrar jogador',
            iconData: Icons.person_add,
            onPressed: _cadastrarJogador,
          ),
        );
      }
    );
  }
  
  @override
  void dispose() {
    _controllerAnimacao.dispose();
    _ctrlNome.dispose();
    super.dispose();
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

  ///Método para cadastrar um novo jogador.
  Future<void> _cadastrarJogador() async {
    if(_formKey.currentState != null && _formKey.currentState!.validate()){
      Jogador jogador = Jogador(nome: _ctrlNome.text, tipo: _tipoSelecionado, qualidade: _qualidadeSelecionada);

      await _jogadorController.registrarJogador(jogador).then((mensagemErro){
        if(mounted){
          if (mensagemErro.isNotEmpty) return showSnackBar(context, BoxSnackBar.erro(mensagem: mensagemErro));
          showSnackBar(context, const BoxSnackBar.successo(mensagem: 'Jogador salvo com sucesso.'));
          Get.back();
        }
      });
    }
  }
}