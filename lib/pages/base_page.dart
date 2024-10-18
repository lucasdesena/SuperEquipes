import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_icon.dart';
import 'package:super_equipes/controllers/navegacao_controller.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';
import 'package:super_equipes/pages/inicio_page.dart';
import 'package:super_equipes/pages/sorteio_menu_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final NavegacaoController _navegacaoController = Get.find<NavegacaoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _navegacaoController.pageController,
        children: const [
          InicioPage(),
          SorteioMenuPage(),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: const Alignment(0.8, 1),
                colors: [
                  Get.theme.colorScheme.secondaryContainer,
                  Get.theme.colorScheme.inversePrimary,
                  Get.theme.colorScheme.primaryContainer,
                  Get.theme.colorScheme.tertiaryContainer,
                ],
              ).createShader(bounds);
            },
            child: BottomNavigationBar(
              selectedLabelStyle: bodyStyle,
              unselectedLabelStyle: bodyStyle,
              currentIndex: _navegacaoController.currentIndex,
              onTap: (index) => _navegacaoController.navegar(index),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: BoxIcon(iconData: Icons.home_filled),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: BoxIcon(iconData:  Icons.sports_esports_outlined),
                  label: 'Sortear',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
