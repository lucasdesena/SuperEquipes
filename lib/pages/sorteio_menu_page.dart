import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_ink_button.dart';
import 'package:super_equipes/core/routes.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

class SorteioMenuPage extends StatefulWidget {
  const SorteioMenuPage({super.key});

  @override
  State<SorteioMenuPage> createState() => _SorteioMenuPageState();
}

class _SorteioMenuPageState extends State<SorteioMenuPage> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: UIText.title('Sorteio'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BoxInkButton(
                  title: 'Sorteio padrão',
                  description: 'Aqui você sorteia seus times baseado nos jogadores selecionados com suas qualidades.',
                  onPressed: () => Get.toNamed(Routes.sorteioPadraoRoute),
                  color: Get.theme.colorScheme.inversePrimary,
                ),
                BoxInkButton(
                  title: 'Sorteio um por um',
                  description: 'Aqui você sorteia seus times um jogador de cada vez, baseado nas cores escolhidas.',
                  onPressed: () => Get.toNamed(Routes.sorteioUmPorUm),
                  color: Get.theme.colorScheme.secondaryContainer,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}