import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

const int totalColumns = 15;
const int totalRows = 15;
const double mockupWidth = 360.0;
const double mockupHeight = 640.0;

///Classe de responsividade da aplicação.
extension ThemeDataExtension on ThemeData {
  double escalaOrientadaAltura(double size) => Device.orientation == Orientation.portrait ? size.h : size.w;
  double escalaOrientadaLargura(double size) => Device.orientation == Orientation.portrait ? size.w : size.h;
  double get columnSize => Device.orientation == Orientation.portrait ? (100 / totalColumns).w : (100 / totalColumns).h;
  double get rowSize => Device.orientation == Orientation.portrait ? (100 / totalRows).h : (100 / totalRows).w;
  double get maxWidth => Device.orientation == Orientation.portrait ? 100.0.w : 100.0.h;
  double get maxHeight => Device.orientation == Orientation.portrait ? 100.0.h : 100.0.w;
}

///Extensão de tamanho criada para o tipo `num`.
extension SizerExt on num {
  ///s = scale (aumentar/diminuir proporcionalmente a largura da tela aplicando o fator de proporcao quando o dispositivo for tablet).
  double get s => this * fator(0);

  double get s1 => this * fator(1);

  double get s2 => this * fator(2);

  double get s3 => this * fator(3);

  double get s4 => this * fator(4);

  double get s5 => this * fator(5);

  ///r = resize (aumentar/diminuir proporcionalmente a largura da tela).
  double get r => this * (Device.width / mockupWidth);
}

///Retorna o dispositivo usado pelo usuario.
ScreenType get device {
  if (Platform.isAndroid || Platform.isIOS) {
    if (Device.width < 720) {
      return ScreenType.mobile;
    } else {
      return ScreenType.tablet;
    }
  } else {
    return Device.screenType;
  }
}

///Método que calcula o fator de escala baseado em um multiplicador.
///* `multiplicador` - Valor inteiro que influencia o cálculo do limite de largura
double fator(int multiplicador) {
  var limite = 500 + (500 * 0.1 * multiplicador);

  if (device == ScreenType.tablet) {
    return ((Device.width <= limite ? Device.width : limite) / mockupWidth);
  } else {
    return (Device.width / mockupWidth);
  }
}

///Método que calcula a quantidade de itens por linha baseado na orientação e tipo do dispositivo e do tipo passado.
///* `context` - Contexto em que o método será chamado
///* `tipo` - Número inteiro que identifica qual caso irá retornar
int getCrossAxisCount(context, {int tipo = 1}) {
  return switch(tipo){
    1 => isMobile ? MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 3 : 4,
    2 => MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2,
    _ => isMobile ? MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 3 : 4,
  };
}

///Como estamos em modo paisagem (landscape), a largura se torna a altura, então a validação é baseada
///na altura quando o dispositivo está deitado. Geralmente, tablets têm uma altura maior que 400.
bool get isMobile => device == ScreenType.mobile && Device.width <= 430; 
