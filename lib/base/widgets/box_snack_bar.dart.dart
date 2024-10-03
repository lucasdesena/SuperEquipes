// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:super_equipes/base/enum/snack_bar_type.dart';
import 'package:super_equipes/core/theme/responsivity.dart';

///Classe responsável por criar as mensagens customizadas da aplicação, de acordo com o tipo da mesma.
class BoxSnackBar extends StatelessWidget {
  final String message;

  final SnackBarType type;

  const BoxSnackBar({
    required this.message,
    required this.type,
  });

  const BoxSnackBar.success({
    required this.message,
    this.type = SnackBarType.success,
  });

  const BoxSnackBar.info({
    required this.message,
    this.type = SnackBarType.info,
  });

  const BoxSnackBar.error({
    required this.message,
    this.type = SnackBarType.error,
  });

  const BoxSnackBar.warning({
    required this.message,
    this.type = SnackBarType.warning,
  });

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      duration: getDuration(),
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
                  color: getColor(context),
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
                getIcon(),
                color: getColor(context),
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
                child: Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar getSnackBar(BuildContext context) => build(context);

  Color getColor(BuildContext context) {
    switch (type) {
      case SnackBarType.success:
        return Theme.of(context).colorScheme.primaryFixed;
      case SnackBarType.info:
        return Theme.of(context).colorScheme.secondary;
      case SnackBarType.warning:
        return Theme.of(context).colorScheme.tertiary;
      case SnackBarType.error:
        return Theme.of(context).colorScheme.error;
    }
  }

  Duration getDuration() {
    switch (type) {
      case SnackBarType.success:
        return const Duration(seconds: 5);
      case SnackBarType.info:
        return const Duration(seconds: 5);
      case SnackBarType.warning:
        return const Duration(seconds: 5);
      case SnackBarType.error:
        return const Duration(seconds: 5);
    }
  }

  IconData getIcon() {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.info:
        return Icons.info;
      case SnackBarType.warning:
        return Icons.error;
      case SnackBarType.error:
        return Icons.cancel;
    }
  }
}

void showSnackBar(BuildContext context, BoxSnackBar boxSnackBar) => ScaffoldMessenger.of(context).showSnackBar(boxSnackBar.getSnackBar(context));
