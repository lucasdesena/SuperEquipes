import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:super_equipes/controllers/tema_controller.dart';
import 'package:super_equipes/core/theme/styles.dart';
import 'package:super_equipes/pages/home_page.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///Fazendo com que o app obtenha as fonts localmente e não por HTTP.
  GoogleFonts.config.allowRuntimeFetching = false;

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
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Obx(() {
          return GetMaterialApp(
            title: 'Super Equipes',
            debugShowCheckedModeBanner: false,
            theme: Styles().light(),
            darkTheme: Styles().dark(),
            themeMode: Get.find<TemaController>().tema,
            scaffoldMessengerKey: scaffoldMessengerKey,
            locale: const Locale('pt', 'BR'),
            home: const HomePage()
          );
        });
      }
    );
  }
}
