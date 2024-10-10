import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Classe que controla o tema.
class TemaController extends GetxController {
  RxBool isModoEscuro = false.obs;

  ///Checa qual tema está sendo utilizado.
  ThemeMode get tema => isModoEscuro.value ? ThemeMode.dark : ThemeMode.light;

  ///Método que altera entre os temas `claro` e `escuro`.
  void alterarTema() => isModoEscuro.value = !isModoEscuro.value;
}
