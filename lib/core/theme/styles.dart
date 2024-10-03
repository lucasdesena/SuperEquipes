import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:super_equipes/controllers/tema_controller.dart';
import 'package:super_equipes/core/theme/responsivity.dart';

///Classe de estilos e temas para aplicação.
class Styles {
  final TemaController _temaController = Get.find<TemaController>();
  
  ///Permite a customização de certas partes do sistema, enquanto tiver usando a aplicação.
  SystemUiOverlayStyle get systemUiOverlay => SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: _temaController.isModoEscuro.value ? Colors.black : Colors.white,
    systemNavigationBarDividerColor: _temaController.isModoEscuro.value ? Colors.black : Colors.white,
    statusBarIconBrightness: _temaController.isModoEscuro.value ? Brightness.light : Brightness.dark,
    systemNavigationBarIconBrightness: _temaController.isModoEscuro.value ? Brightness.light : Brightness.dark,
  );

   static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff39693c),
      surfaceTint: Color(0xff39693c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbaf0b7),
      onPrimaryContainer: Color(0xff002106),
      secondary: Color(0xff745b0c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffe08f),
      onSecondaryContainer: Color(0xff241a00),
      tertiary: Color(0xff39656b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcebf2),
      onTertiaryContainer: Color(0xff001f23),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff181d17),
      onSurfaceVariant: Color(0xff424940),
      outline: Color(0xff72796f),
      outlineVariant: Color(0xffc2c9bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff9ed49c),
      primaryFixed: Color(0xffbaf0b7),
      onPrimaryFixed: Color(0xff002106),
      primaryFixedDim: Color(0xff9ed49c),
      onPrimaryFixedVariant: Color(0xff205026),
      secondaryFixed: Color(0xffffe08f),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe4c36c),
      onSecondaryFixedVariant: Color(0xff584400),
      tertiaryFixed: Color(0xffbcebf2),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff1f4d53),
      surfaceDim: Color(0xffd7dbd3),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe6e9e1),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1c4c22),
      surfaceTint: Color(0xff39693c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4f8050),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff544000),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8c7123),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a494f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f7c82),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff181d17),
      onSurfaceVariant: Color(0xff3e453c),
      outline: Color(0xff5a6158),
      outlineVariant: Color(0xff767d73),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff9ed49c),
      primaryFixed: Color(0xff4f8050),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff366639),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8c7123),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff715908),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f7c82),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff366369),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dbd3),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe6e9e1),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002909),
      surfaceTint: Color(0xff39693c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1c4c22),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2c2100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff544000),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00272b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a494f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf2),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1f261e),
      outline: Color(0xff3e453c),
      outlineVariant: Color(0xff3e453c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xffc3fac0),
      primaryFixed: Color(0xff1c4c22),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff01350e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff544000),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff392b00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff1a494f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003238),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dbd3),
      surfaceBright: Color(0xfff7fbf2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffebefe6),
      surfaceContainerHigh: Color(0xffe6e9e1),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9ed49c),
      surfaceTint: Color(0xff9ed49c),
      onPrimary: Color(0xff053911),
      primaryContainer: Color(0xff205026),
      onPrimaryContainer: Color(0xffbaf0b7),
      secondary: Color(0xffe4c36c),
      onSecondary: Color(0xff3d2e00),
      secondaryContainer: Color(0xff584400),
      onSecondaryContainer: Color(0xffffe08f),
      tertiary: Color(0xffa1ced5),
      onTertiary: Color(0xff00363c),
      tertiaryContainer: Color(0xff1f4d53),
      onTertiaryContainer: Color(0xffbcebf2),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101410),
      onSurface: Color(0xffe0e4db),
      onSurfaceVariant: Color(0xffc2c9bd),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff424940),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff39693c),
      primaryFixed: Color(0xffbaf0b7),
      onPrimaryFixed: Color(0xff002106),
      primaryFixedDim: Color(0xff9ed49c),
      onPrimaryFixedVariant: Color(0xff205026),
      secondaryFixed: Color(0xffffe08f),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe4c36c),
      onSecondaryFixedVariant: Color(0xff584400),
      tertiaryFixed: Color(0xffbcebf2),
      onTertiaryFixed: Color(0xff001f23),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff1f4d53),
      surfaceDim: Color(0xff101410),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff181d17),
      surfaceContainer: Color(0xff1c211b),
      surfaceContainerHigh: Color(0xff272b26),
      surfaceContainerHighest: Color(0xff313630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa3d8a0),
      surfaceTint: Color(0xff9ed49c),
      onPrimary: Color(0xff001b04),
      primaryContainer: Color(0xff6a9d6a),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe8c770),
      onSecondary: Color(0xff1e1500),
      secondaryContainer: Color(0xffaa8e3d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa5d3da),
      onTertiary: Color(0xff001a1d),
      tertiaryContainer: Color(0xff6c989f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101410),
      onSurface: Color(0xfff8fcf3),
      onSurfaceVariant: Color(0xffc6cdc1),
      outline: Color(0xff9ea59a),
      outlineVariant: Color(0xff7e857b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff225227),
      primaryFixed: Color(0xffbaf0b7),
      onPrimaryFixed: Color(0xff001603),
      primaryFixedDim: Color(0xff9ed49c),
      onPrimaryFixedVariant: Color(0xff0d3f17),
      secondaryFixed: Color(0xffffe08f),
      onSecondaryFixed: Color(0xff181000),
      secondaryFixedDim: Color(0xffe4c36c),
      onSecondaryFixedVariant: Color(0xff443400),
      tertiaryFixed: Color(0xffbcebf2),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xffa1ced5),
      onTertiaryFixedVariant: Color(0xff083c42),
      surfaceDim: Color(0xff101410),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff181d17),
      surfaceContainer: Color(0xff1c211b),
      surfaceContainerHigh: Color(0xff272b26),
      surfaceContainerHighest: Color(0xff313630),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff0ffeb),
      surfaceTint: Color(0xff9ed49c),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa3d8a0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe8c770),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0fdff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa5d3da),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101410),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff6fdf1),
      outline: Color(0xffc6cdc1),
      outlineVariant: Color(0xffc6cdc1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff00320c),
      primaryFixed: Color(0xffbef5bb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa3d8a0),
      onPrimaryFixedVariant: Color(0xff001b04),
      secondaryFixed: Color(0xffffe4a4),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe8c770),
      onSecondaryFixedVariant: Color(0xff1e1500),
      tertiaryFixed: Color(0xffc1eff6),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa5d3da),
      onTertiaryFixedVariant: Color(0xff001a1d),
      surfaceDim: Color(0xff101410),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff181d17),
      surfaceContainer: Color(0xff1c211b),
      surfaceContainerHigh: Color(0xff272b26),
      surfaceContainerHighest: Color(0xff313630),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    ///Necessário para trocar as cores do texto, background e icone de fechar o snackbar.
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(color: colorScheme.onSurface),
      backgroundColor: _temaController.isModoEscuro.value ? colorScheme.surfaceContainerHighest : colorScheme.surface,
      closeIconColor: colorScheme.onSurface,
    ),
    ///Necessário para diminuir o tamanho do espaçamento do textbutton.
    textButtonTheme: const TextButtonThemeData(style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
    ///Necessário para remover o efeito de clique que ultrapassa o shape do bottomSheet.
    bottomSheetTheme: const BottomSheetThemeData(clipBehavior: Clip.antiAlias),
    ///Necessário para alterar o tamanho do icone de voltar do appBar.
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(size: 22.s2)),
    ///Necessário para limitar o conteúdo de dentro do card ao tamanho do mesmo.
    cardTheme: const CardTheme(clipBehavior: Clip.hardEdge),
  );
}