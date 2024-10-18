import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

///Um dialog simples customizavel
class BoxAlertDialog extends StatelessWidget {
  final String? title;
  final Widget? image;
  final String content;
  final List<Widget>? actions;

  const BoxAlertDialog({
    super.key,
    this.title,
    this.image,
    required this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10.s5),
      contentPadding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
      title: image ?? UIText.dialogTitle(title!),
      content: UIText.dialogContent(content, maxLines: 3),
      actions: actions ?? [],
    );
  }
}
