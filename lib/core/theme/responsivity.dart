import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

const int totalColumns = 15;
const int totalRows = 15;
const double mockupWidth = 360.0;
const double mockupHeight = 640.0;

///Classe de responsividade da aplicação.
extension ThemeDataExtension on ThemeData {
  double escalaOrientadaAltura(double size) => size.h;
  double escalaOrientadaLargura(double size) => size.w;
  double get columnSize => (100 / totalColumns).w;
  double get rowSize => (100 / totalRows).h;
  double get maxWidth => 100.0.w;
  double get maxHeight => 100.0.h;
}

///Extensão de tamanho criada para o tipo `num`.
extension SizerExt on num {
  /// s = scale (ajusta com base no fator de proporção para dispositivos tablets).
  double get s => this * fator(0);

  double get s1 => this * fator(1);

  double get s2 => this * fator(2);

  double get s3 => this * fator(3);

  double get s4 => this * fator(4);

  double get s5 => this * fator(5);

  /// r = resize (ajusta com base na proporção da largura da tela).
  double get r => this * (isPortrait ? Device.width / mockupWidth : Device.height / mockupHeight);
}

///Retorna o dispositivo usado pelo usuário.
///Quando estamos em modo paisagem (landscape), a largura se torna a altura, então a validação é baseada
///na altura quando o dispositivo está deitado. Geralmente, tablets têm uma altura maior que 430.
ScreenType get device {
  final double screenSize = isPortrait ? Device.width : Device.height;
  if (Platform.isAndroid || Platform.isIOS) {
    return screenSize < 430 ? ScreenType.mobile : ScreenType.tablet;
  }
  return Device.screenType;
}

///Método que calcula o fator de escala baseado em um multiplicador.
double fator(int multiplicador) {
  const int limiteBase = 500;
  double limite = limiteBase + (limiteBase * 0.1 * multiplicador);

  if (device == ScreenType.tablet) {
    double screenLimit = isPortrait ? Device.width : Device.height;
    return (screenLimit <= limite ? screenLimit : limite) / mockupWidth;
  }
  return (isPortrait ? Device.width : Device.height) / mockupWidth;
}

///Método que calcula a quantidade de itens por linha baseado na orientação e tipo do dispositivo.
int getCrossAxisCount({int tipo = 1}) {
  final quantidadeBase = (isMobile && isPortrait) ? 3 : 4;
  return tipo == 2 ? (isPortrait ? 2 : 4) : quantidadeBase;
}

///Checa se é um celular
bool get isMobile => device == ScreenType.mobile;

///Checa se a tela está na orientação portrait (retrato).
bool get isPortrait => Device.orientation == Orientation.portrait;
