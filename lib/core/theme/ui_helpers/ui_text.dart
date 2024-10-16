import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/fonts.dart';

class UIText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextAlign? textAlign; 

  UIText.title(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = titleStyle;
  UIText.subtitle(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = subtitleStyle;
  UIText.body(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = bodyStyle;
  UIText.textField(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = textFieldStyle;
  UIText.fab(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = fabStyle;
  UIText.inkTitle(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = inkTitleStyle;
  UIText.inkSubTitle(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = inkSubTitleStyle;
  UIText.timeTitle(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = timeTitleStyle;
  UIText.nomeJogador (this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = nomeJogadorStyle;
  UIText.estatistica (this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = estatisticaStyle;
  UIText.nomeJogadorMinor(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = nomeJogadorStyleMinor;
  UIText.estatisticaMinor(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = estatisticaStyleMinor;
  UIText.hint(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = hintStyle;
  UIText.error(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = errorStyle;
  UIText.dialogTitle(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dialogTitleStyle;
  UIText.dialogContent(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dialogContentStyle;
  UIText.dialogConfirm(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dialogConfirmStyle;
  UIText.dialogCancel(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dialogCancelStyle;
  UIText.tituloImagem(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = tituloImagemStyle;
  UIText.subTituloImagem(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = subTituloImagemStyle;

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
