import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
          tipoJogador == TipoJogador.goleiro ? FadeInImage(
                placeholder: AssetImage('assets/images/card_goleiro_$qualidade.png'),
                image: AssetImage('assets/images/card_goleiro_$qualidade.png'),
              )
            : FadeInImage(
                placeholder: AssetImage('assets/images/card_jogador_$qualidade.png'),
                image: AssetImage('assets/images/card_jogador_$qualidade.png'),
              ),
          Positioned(
            bottom: Device.orientation == Orientation.portrait ? 61.5.s5 : isMobile ? 68.s5 : 55.s5,
            child: Container(
              margin: Device.height > 1000 ? const EdgeInsets.only(bottom: 10) : EdgeInsets.zero,
              child: UIText.nomeJogadorMinor(nome.length > 14 ? nome.substring(0, 14) : nome),
            ),
          ),
          Positioned(
            bottom: !isMobile && Device.orientation == Orientation.portrait ? 21.s5 : 19.5.s5,
            child: Container(
              margin: Device.height > 1000 ? const EdgeInsets.only(bottom: 10) : EdgeInsets.zero,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(qualidade, 'VEL'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(qualidade, 'DRI'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(qualidade, 'CHU'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(qualidade, 'DEF'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(qualidade, 'PAS'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(qualidade, 'FIS'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget _estatisticaWidget(int qualidadeJogador, String label) {
    return Row(
      children: [
        UIText.estatisticaMinor(_getQualidadeJogador(qualidadeJogador)),
        const SizedBox(width: 5),
        UIText.estatisticaMinor(label),
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