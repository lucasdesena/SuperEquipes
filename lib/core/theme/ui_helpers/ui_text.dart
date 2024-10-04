import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/fonts.dart';

class UIText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextAlign? textAlign; 

  UIText.estatistica(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = estatisticaStyle;

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
