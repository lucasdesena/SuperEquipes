import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:super_equipes/controllers/jogador_controller.dart';
import 'package:super_equipes/controllers/navegacao_controller.dart';
import 'package:super_equipes/controllers/tema_controller.dart';
import 'package:super_equipes/core/routes.dart';
import 'package:super_equipes/core/theme/styles.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';
import 'package:super_equipes/models/jogador.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  ///Mantendo a splashscreen na tela.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();

  ///Registrando os adaptadores de objeto para o hive.
  Hive.registerAdapter(JogadorAdapter());
  Hive.registerAdapter(TipoJogadorAdapter());

  ///Criando a tabela.
  await Hive.openBox<Jogador>('jogadores');

  ///Fazendo com que o app obtenha as fonts localmente e não por HTTP.
  GoogleFonts.config.allowRuntimeFetching = false;

  ///Adicionando as licenças das fontes do Google.
  LicenseRegistry.addLicense(() async* {
    final poppinsLicense = await rootBundle.loadString('assets/google_fonts/Poppins/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts', 'poppins'], poppinsLicense);
    final robotoLicense = await rootBundle.loadString('assets/google_fonts/Roboto/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts', 'roboto'], robotoLicense);
  });

  ///Injetando a denpedencia de forma global assim que o aplicativo inicializa.
  Get.put(TemaController());

  runApp(
    Obx(() {
      return AnnotatedRegion(
        value: Styles().systemUiOverlay,
        child: const SuperEquipes(),
      );
    }),
  );
}

class SuperEquipes extends StatelessWidget {
  const SuperEquipes({super.key});

  ///Método para realizar o carregamento das imagens em cache.
  Future<void> _carregarImagens(BuildContext context) async {
    await Future.wait([
      precacheImage(const AssetImage('assets/images/lista_vazia.png'), context),
      precacheImage(const AssetImage('assets/images/card_padrao.png'), context),
      precacheImage(const AssetImage('assets/images/card_linha_1.png'), context),
      precacheImage(const AssetImage('assets/images/card_linha_2.png'), context),
      precacheImage(const AssetImage('assets/images/card_linha_3.png'), context),
      precacheImage(const AssetImage('assets/images/card_linha_4.png'), context),
      precacheImage(const AssetImage('assets/images/card_linha_5.png'), context),
      precacheImage(const AssetImage('assets/images/card_goleiro_1.png'), context),
      precacheImage(const AssetImage('assets/images/card_goleiro_2.png'), context),
      precacheImage(const AssetImage('assets/images/card_goleiro_3.png'), context),
      precacheImage(const AssetImage('assets/images/card_goleiro_4.png'), context),
      precacheImage(const AssetImage('assets/images/card_goleiro_5.png'), context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return FutureBuilder(
          future: _carregarImagens(context),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) FlutterNativeSplash.remove();

            return Obx(() {
              return GetMaterialApp(
                title: 'Super Equipes',
                debugShowCheckedModeBanner: false,
                theme: Styles().light(),
                darkTheme: Styles().dark(),
                themeMode: Get.find<TemaController>().tema,
                scaffoldMessengerKey: scaffoldMessengerKey,
                locale: const Locale('pt', 'BR'),
                getPages: Pages.pages,
                initialRoute: Routes.baseRoute,
                initialBinding: BindingsBuilder(() {
                  ///Injetando a denpedencia de forma especifica apenas quando uma rota é chamada.
                  Get.put(NavegacaoController());
                  Get.put(JogadorController());
                }),
              );
            });
          },
        );
      },
    );
  }
}
