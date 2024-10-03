import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/core/routes.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Inicio'),
          ),
          floatingActionButton: BoxFloatingActionButton(
            iconData: Icons.add,
            onPressed: () => Get.toNamed(Routes.novoJogadorRoute),
          ),
        );
      }
    );
  }
}