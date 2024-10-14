import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_ink_button.dart';
import 'package:super_equipes/core/routes.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

class SorteioPage extends StatefulWidget {
  const SorteioPage({super.key});

  @override
  State<SorteioPage> createState() => _SorteioPageState();
}

class _SorteioPageState extends State<SorteioPage> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: UIText.title('Sorteio'),
          ),
          body: Column(
            children: [
              BoxInkButton(
                title: 'Sorteio padrão',
                description: 'Aqui você sorteia seus times baseado nos jogadores selecionados com suas qualidades.',
                onPressed: () => Get.toNamed(Routes.sorteioPadraoRoute),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              BoxInkButton(
                title: 'Sorteio um por um',
                description: 'Aqui você sorteia seus times um jogador de cada vez, baseado nas cores escolhidas.',
                onPressed: () {},
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ],
          ),
        );
      }
    );
  }
}