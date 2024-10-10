import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';

TextStyle get titleStyle => GoogleFonts.poppins(fontSize: 20.s2, fontWeight: FontWeight.w500, decoration: TextDecoration.none);
TextStyle get subtitleStyle => GoogleFonts.roboto(fontSize: 14.s2, fontWeight: FontWeight.normal, decoration: TextDecoration.none);
TextStyle get bodyStyle => GoogleFonts.roboto(fontSize: 12.s2, fontWeight: FontWeight.w600, decoration: TextDecoration.none);
TextStyle get textFieldStyle => GoogleFonts.roboto(fontSize: 14.s2, fontWeight: FontWeight.w400, decoration: TextDecoration.none);
TextStyle get fabStyle => GoogleFonts.roboto(fontSize: 14.s2, fontWeight: FontWeight.w500, decoration: TextDecoration.none);
TextStyle get dialogTitleStyle => GoogleFonts.poppins(fontSize: 15.s2, fontWeight: FontWeight.w500, decoration: TextDecoration.none);
TextStyle get dialogConfirmStyle => GoogleFonts.roboto(fontSize: 12.s2, fontWeight: FontWeight.w600, decoration: TextDecoration.none);

TextStyle dialogCancelStyle(BuildContext context) => GoogleFonts.roboto( fontSize: 12.s2, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.error, decoration: TextDecoration.none);
TextStyle nomeJogadorStyle(BuildContext context) => GoogleFonts.roboto(fontSize: 13.s2, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.customColor, decoration: TextDecoration.none);
TextStyle estatisticaStyle(BuildContext context) => GoogleFonts.roboto(fontSize: 12.s2, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.customColor, decoration: TextDecoration.none);
TextStyle nomeJogadorStyleMinor(BuildContext context) => GoogleFonts.roboto(fontSize: 10.5.s2, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.customColor, decoration: TextDecoration.none);
TextStyle estatisticaStyleMinor(BuildContext context) => GoogleFonts.roboto(fontSize: 10.s2, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.customColor, decoration: TextDecoration.none);
TextStyle hintStyle(BuildContext context) => GoogleFonts.roboto(fontSize: 14.s1, fontWeight: FontWeight.w300, color: Theme.of(context).colorScheme.onSurfaceVariant, decoration: TextDecoration.none);
TextStyle errorStyle(BuildContext context) => GoogleFonts.roboto(fontSize: 11.s1, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.error, decoration: TextDecoration.none);
