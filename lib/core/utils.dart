import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Classe de utilidades.
class Utils{
  ///Método que retorna uma cor baseada no índice.
  static Color corFundoCorpo(int index) {
    return switch (index) {
      0 => Get.theme.colorScheme.primaryContainer,
      1 => Get.theme.colorScheme.secondaryContainer,
      2 => Get.theme.colorScheme.tertiaryContainer,
      3 => Get.theme.colorScheme.errorContainer,
      4 => Get.theme.colorScheme.primaryContainer,
      5 => Get.theme.colorScheme.secondaryContainer,
      6 => Get.theme.colorScheme.tertiaryContainer,
      7 => Get.theme.colorScheme.errorContainer,
      8 => Get.theme.colorScheme.primaryContainer,
      9 => Get.theme.colorScheme.secondaryContainer,
      10 => Get.theme.colorScheme.tertiaryContainer,
      11 => Get.theme.colorScheme.errorContainer,
      _ => Colors.transparent,
    };
  }
}