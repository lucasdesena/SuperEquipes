import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

///Constroi card de modulo da homepage
class BoxInkButton extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;
  final Color color;

  const BoxInkButton({
    super.key,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          Theme.of(context).columnSize * 2,
          Theme.of(context).rowSize / 1.3,
          Theme.of(context).columnSize * 2,
          Theme.of(context).rowSize / 1.3,
        ),
        color: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UIText.inkTitle(title),
            SizedBox(
              height: Theme.of(context).rowSize / 3,
            ),
            UIText.inkSubTitle(
              description,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
