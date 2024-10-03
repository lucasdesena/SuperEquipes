import 'package:get/get.dart';
import 'package:super_equipes/pages/base_page.dart';
import 'package:super_equipes/pages/inicio_page.dart';
import 'package:super_equipes/pages/novo_jogador_page.dart';
import 'package:super_equipes/pages/sorteio_page.dart';

abstract class Pages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.baseRoute,
      page: () => const BasePage(),
    ),
    GetPage(
      name: Routes.inicialRoute,
      page: () => const InicioPage(),
    ),
    GetPage(
      name: Routes.novoJogadorRoute,
      page: () => const NovoJogadorPage(),
    ),
    GetPage(
      name: Routes.sorteioRoute,
      page: () => const SorteioPage(),
    ),
  ];
}

abstract class Routes {
  static const String baseRoute = '/base';
  static const String inicialRoute = '/inicial';
  static const String novoJogadorRoute = '/novoJogador';
  static const String sorteioRoute = '/sorteio';
}
