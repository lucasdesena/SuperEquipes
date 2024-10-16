import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/base/widgets/box_icon.dart';
import 'package:super_equipes/base/widgets/box_snack_bar.dart.dart';
import 'package:super_equipes/controllers/jogador_controller.dart';
import 'package:super_equipes/controllers/tema_controller.dart';
import 'package:super_equipes/core/routes.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/models/jogador.dart';
import 'package:super_equipes/base/widgets/box_card_jogador.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final JogadorController _jogadorController = Get.find<JogadorController>();
  final TemaController _temaController = Get.find<TemaController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => await _buscarJogadores());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: UIText.title('Início'),
            actions: [
              IconButton(
                onPressed: () => _temaController.alterarTema(), 
                icon: const BoxIcon(
                  iconData: Icons.brightness_6_outlined,
                )
              ),
            ],
          ),
          body: Obx(() {
              return GridView.builder(
                padding: EdgeInsets.only(bottom: 70.s2),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: Device.width < 600 && orientation == Orientation.landscape ? 0.74 : 1,
                  crossAxisCount: getCrossAxisCount(tipo: 2),
                  crossAxisSpacing: 4, 
                  mainAxisSpacing: 4,
                ),
                itemCount: _jogadorController.jogadores.length,
                itemBuilder: (context, index) {
                  final Jogador jogador = _jogadorController.jogadores[index];
                  return InkWell(
                    onTap: () {
                      _jogadorController.selecionarJogador(jogador);
                      Get.toNamed(Routes.sobreJogadorRoute)?.then((_) async => await _buscarJogadores());
                    },
                    child: BoxCardJogador(nome: jogador.nome, qualidade: jogador.qualidade, tipoJogador: jogador.tipo),
                  );
                },
              );
            },
          ),
          floatingActionButton: BoxFloatingActionButton(
            iconData: Icons.add,
            onPressed: () => Get.toNamed(Routes.novoJogadorRoute)?.then((_) async => await _buscarJogadores()),
          ),
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
