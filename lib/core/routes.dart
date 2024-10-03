import 'package:get/get.dart';
import 'package:super_equipes/pages/inicio_page.dart';

abstract class Pages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.inicialRoute,
      page: () => const InicioPage(),
    )
  ];
}

abstract class Routes {
  static const String inicialRoute = '/inicial';
}
