import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Classe de utilidades.
class Utils{
  ///Método que retorna uma cor baseada no índice.
  static Color corFundoCorpo(int index) {
    final List<Color> cores = [
      Get.theme.colorScheme.primaryContainer,
      Get.theme.colorScheme.secondaryContainer,
      Get.theme.colorScheme.tertiaryContainer,
      Get.theme.colorScheme.errorContainer,
    ];

    return cores[index % cores.length];
  }
}