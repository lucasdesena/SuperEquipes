import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///Classe que controla a navegação.
class NavegacaoController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  ///Atribui os valores iniciais necessários ao iniciar o controller.
  @override
  void onInit() {
    super.onInit();
    _iniciarNavegacao(
      pageController: PageController(initialPage: 0),
      currentIndex: 0,
    );
  }

  ///Método para iniciar as variáveis de navegação.
  void _iniciarNavegacao({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  ///Método para resetar as variáveis de navegação.
  void resetarNavegacao(){
     _iniciarNavegacao(
      pageController: PageController(initialPage: 0),
      currentIndex: 0,
    );
  }

  ///Método para mudar de página
  void navegar(int page) {
    if (_currentIndex.value == page) return;
    
    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }
}
