import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_floating_action_button.dart';
import 'package:super_equipes/core/routes.dart';
import 'package:super_equipes/core/theme/responsivity.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: getCrossAxisCount(context, tipo: 2)),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(4.0),
            child: Card(),
          );
        },
      ),
      floatingActionButton: BoxFloatingActionButton(
        iconData: Icons.add,
        onPressed: () => Get.toNamed(Routes.novoJogadorRoute),
      ),
    );
  }
}
