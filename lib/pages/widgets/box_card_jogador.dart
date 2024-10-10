import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';

class BoxCardJogador extends StatelessWidget {
  final String nome;
  final int qualidade;
  final TipoJogador tipoJogador;

  const BoxCardJogador({
    super.key,
    required this.nome,
    required this.qualidade,
    required this.tipoJogador,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          tipoJogador == TipoJogador.goleiro ? Image.asset('assets/images/card_goleiro.png') : Image.asset('assets/images/card_jogador.png'),
          Positioned(
            bottom: 140 * 0.5,
          child: UIText.nomeJogadorMinor(
              context,
              nome.length > 11 ? '${nome.substring(0, 11)}...' : nome,
            ),
          ),
          Positioned(
            bottom: 42 * 0.5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _estatisticaWidget(context, qualidade, 'VEL'),
                    SizedBox(width: 25.s * 0.5),
                    _estatisticaWidget(context, qualidade, 'DRI'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _estatisticaWidget(context, qualidade, 'CHU'),
                    SizedBox(width: 25.s * 0.5),
                    _estatisticaWidget(context, qualidade, 'DEF'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _estatisticaWidget(context, qualidade, 'PAS'),
                    SizedBox(width: 25.s * 0.5),
                    _estatisticaWidget(context, qualidade, 'FIS'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _estatisticaWidget(BuildContext context, int qualidadeJogador, String label) {
    return Row(
      children: [
        UIText.estatisticaMinor(
          context,
          _getQualidadeJogador(qualidadeJogador),
        ),
        const SizedBox(width: 5),
        UIText.estatisticaMinor(
          context,
          label,
        ),
      ],
    );
  }
  
  String _getQualidadeJogador(int qualidadeJogador) {
    return switch (qualidadeJogador) {
      1 => '-1',
      2 => '10',
      3 => '50',
      4 => '80',
      5 => '99',
      _ => '...',
    };
  }
}