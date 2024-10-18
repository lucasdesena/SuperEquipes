import 'package:get/get.dart';
import 'package:super_equipes/pages/base_page.dart';
import 'package:super_equipes/pages/inicio_page.dart';
import 'package:super_equipes/pages/novo_jogador_page.dart';
import 'package:super_equipes/pages/sobre_jogador_page.dart';
import 'package:super_equipes/pages/sorteio_padrao_page.dart';
import 'package:super_equipes/pages/sorteio_menu_page.dart';
import 'package:super_equipes/pages/sorteio_um_por_um_page.dart';

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
      name: Routes.sobreJogadorRoute,
      page: () => const SobreJogadorPage(),
    ),
    GetPage(
      name: Routes.sorteioMenuRoute,
      page: () => const SorteioMenuPage(),
    ),
    GetPage(
      name: Routes.sorteioPadraoRoute,
      page: () => const SorteioPadraoPage(),
    ),
    GetPage(
      name: Routes.sorteioPadraoRoute,
      page: () => const SorteioPadraoPage(),
    ),
    GetPage(
      name: Routes.sorteioUmPorUm,
      page: () => const SorteioUmPorUmPage(),
    ),
  ];
}

abstract class Routes {
  static const String baseRoute = '/base';
  static const String inicialRoute = '/inicial';
  static const String novoJogadorRoute = '/novoJogador';
  static const String sobreJogadorRoute = '/sobreJogador';
  static const String sorteioMenuRoute = '/sorteioMenu';
  static const String sorteioPadraoRoute = '/sorteioPadrao';
  static const String sorteioUmPorUm = '/sorteioUmPorUm';
}
