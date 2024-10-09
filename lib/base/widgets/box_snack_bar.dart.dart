// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:super_equipes/models/enum/tipo_snack_bar.dart';
import 'package:super_equipes/core/theme/responsivity.dart';

///Classe responsável por criar as mensagens customizadas da aplicação, de acordo com o tipo da mesma.
class BoxSnackBar extends StatelessWidget {
  final String mensagem;

  final TipoSnackBar tipo;

  const BoxSnackBar({
    required this.mensagem,
    required this.tipo,
  });

  const BoxSnackBar.successo({
    required this.mensagem,
    this.tipo = TipoSnackBar.sucesso,
  });

  const BoxSnackBar.informacao({
    required this.mensagem,
    this.tipo = TipoSnackBar.informacao,
  });

  const BoxSnackBar.aviso({
    required this.mensagem,
    this.tipo = TipoSnackBar.aviso,
  });

    const BoxSnackBar.erro({
    required this.mensagem,
    this.tipo = TipoSnackBar.erro,
  });

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      duration: duracao(),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      showCloseIcon: true,
      content: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(10.r)),
                  color: cor(context),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(width: 15.0.r)
            ),
            Flexible(
              flex: 2,
              child: Icon(
                icone(),
                color: cor(context),
                size: 23.s,
              ),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(
                width: 15.r,
              ),
            ),
            Flexible(
              flex: 30,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.r),
                child: Text(mensagem),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar getSnackBar(BuildContext context) => build(context);

  Color cor(BuildContext context) {
    switch (tipo) {
      case TipoSnackBar.sucesso:
        return Theme.of(context).colorScheme.primaryFixed;
      case TipoSnackBar.informacao:
        return Theme.of(context).colorScheme.secondary;
      case TipoSnackBar.aviso:
        return Theme.of(context).colorScheme.tertiary;
      case TipoSnackBar.erro:
        return Theme.of(context).colorScheme.error;
    }
  }

  Duration duracao() {
    switch (tipo) {
      case TipoSnackBar.sucesso:
        return const Duration(seconds: 5);
      case TipoSnackBar.informacao:
        return const Duration(seconds: 5);
      case TipoSnackBar.aviso:
        return const Duration(seconds: 5);
      case TipoSnackBar.erro:
        return const Duration(seconds: 5);
    }
  }

  IconData icone() {
    switch (tipo) {
      case TipoSnackBar.sucesso:
        return Icons.check_circle;
      case TipoSnackBar.informacao:
        return Icons.info;
      case TipoSnackBar.aviso:
        return Icons.error;
      case TipoSnackBar.erro:
        return Icons.cancel;
    }
  }
}

void showSnackBar(BuildContext context, BoxSnackBar boxSnackBar) => ScaffoldMessenger.of(context).showSnackBar(boxSnackBar.getSnackBar(context));
