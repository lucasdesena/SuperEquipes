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

class NovoJogadorPage extends StatefulWidget {
  const NovoJogadorPage({super.key});

  @override
  State<NovoJogadorPage> createState() => _NovoJogadorPageState();
}

class _NovoJogadorPageState extends State<NovoJogadorPage> {
  final JogadorController _jogadorController = Get.find<JogadorController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlNome = TextEditingController();
  final List<String> _qualidades = ['Peréba', 'Ruim', 'Normal', 'Bom', 'Craque'];
  final List<bool> _selectedChips = [true, false, false, false, false];

  TipoJogador _tipoSelecionado = TipoJogador.linha;
  int _qualidadeSelecionada = 1;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: UIText.title('Novo Jogador'),
          ),
          body: UIPadding(
            useVerticalPadding: true,
            useHorizontalPadding: true,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  BoxTextField(
                    label: 'Nome:',
                    controller: _ctrlNome,
                    hintText: 'Insira o nome do jogador',
                    validatorFunction: Validators.validarNome,
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
                      setState(() {
                        _tipoSelecionado = novoValor.first == 'linha' ? TipoJogador.linha : TipoJogador.goleiro;
                      });
                    },
                  ),
                  SizedBox(height: 10.s),
                  SizedBox(
                    height: 50.s,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: _qualidades.length,
                      separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.symmetric(horizontal: 4)), 
                      itemBuilder: (context, index) {
                        return ChoiceChip(
                          label: UIText.body(_qualidades[index]), 
                          selected: _selectedChips[index],
                          onSelected: (_) {
                            setState(() {
                              if (!_selectedChips[index]) {
                                ///Marca o chip selecionado e desmarcar todos os outros.
                                for (int i = 0; i < _selectedChips.length; i++) {
                                  _selectedChips[i] = i == index;
                                  i == index ? setState(() => _qualidadeSelecionada = i + 1) : null;
                                }
                              }
                            });
                          },
                        );
                      }, 
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          floatingActionButton: BoxFloatingActionButton(
            extended: true,
            label: 'Novo jogador',
            iconData: Icons.person_add_alt,
            onPressed: () async => await _cadastrarJogador(),
          ),
        );
      }
    );
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