import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/fonts.dart';

class UIText extends StatelessWidget {
  final BuildContext? context;
  final String text;
  final TextStyle style;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextAlign? textAlign; 

  UIText.title(this.text, {super.key, this.context, this.textOverflow, this.maxLines, this.textAlign}) : style = titleStyle;
  UIText.subtitle(this.text, {super.key, this.context, this.textOverflow, this.maxLines, this.textAlign}) : style = subtitleStyle;
  UIText.body(this.text, {super.key, this.context, this.textOverflow, this.maxLines, this.textAlign}) : style = bodyStyle;
  UIText.textField(this.text, {super.key, this.context, this.textOverflow, this.maxLines, this.textAlign}) : style = textFieldStyle;
  UIText.fab(this.text, {super.key, this.context, this.textOverflow, this.maxLines, this.textAlign}) : style = fabStyle;
  UIText.dialogTitle(this.text, {super.key, this.context, this.textOverflow, this.maxLines, this.textAlign}) : style = dialogTitleStyle;
  UIText.dialogConfirm(this.text, {super.key, this.context, this.textOverflow, this.maxLines, this.textAlign}) : style = dialogConfirmStyle;

  UIText.dialogCancel(this.context, this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dialogCancelStyle(context!);
  UIText.estatistica(this.context, this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = estatisticaStyle(context!);
  UIText.hint(this.context, this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = hintStyle(context!);
  UIText.error(this.context, this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = errorStyle(context!);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,  
      textAlign: textAlign,
    );
  }
}
