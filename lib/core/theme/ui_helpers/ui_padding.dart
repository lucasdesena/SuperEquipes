import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/responsivity.dart';

///Cria um padding para o widget, seguindo a regra do aplicativo
class UIPadding extends StatelessWidget {
  final Widget? child;
  final bool useHorizontalPadding;
  final bool useVerticalPadding;

  const UIPadding({
    super.key,
    required this.child,
    this.useHorizontalPadding = false,
    this.useVerticalPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: useHorizontalPadding ? (isPortrait ? Theme.of(context).columnSize : Theme.of(context).columnSize * 2) : 0,
        vertical: useVerticalPadding ? Theme.of(context).rowSize * 0.7 : 0,
      ),
      child: child,
    );
  }
}