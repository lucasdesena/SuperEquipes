import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/responsivity.dart';

class BoxAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  const BoxAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      actions: actions,
    );
  }

  ///Necessário para deixar o tamanho do appbar responsivo.
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.s2);
}