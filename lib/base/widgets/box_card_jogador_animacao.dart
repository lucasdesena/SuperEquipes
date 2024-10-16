import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';

class BoxCardJogadorAnimacao extends StatefulWidget {
  final String nome;
  final int qualidade;
  final Animation<int> qualidadeAnimada;
  final TipoJogador tipoJogador;

  const BoxCardJogadorAnimacao({
    super.key,
    required this.nome,
    required this.qualidade,
    required this.qualidadeAnimada,
    required this.tipoJogador,
  });

  @override
  State<BoxCardJogadorAnimacao> createState() => _BoxCardJogadorAnimacaoState();
}

class _BoxCardJogadorAnimacaoState extends State<BoxCardJogadorAnimacao> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.s2,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.tipoJogador == TipoJogador.goleiro ? FadeInImage(
                placeholder: AssetImage('assets/images/card_goleiro_${widget.qualidade}.png'),
                image: AssetImage('assets/images/card_goleiro_${widget.qualidade}.png'),
              )
            : FadeInImage(
                placeholder: AssetImage('assets/images/card_jogador_${widget.qualidade}.png'),
                image: AssetImage('assets/images/card_jogador_${widget.qualidade}.png'),
              ),
            Positioned(
              bottom: 88.s2,
              child: UIText.nomeJogador(widget.nome.length > 14 ? widget.nome.substring(0, 14) : widget.nome),
            ),
            Positioned(
              bottom: 32.s2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(widget.qualidadeAnimada, 'VEL'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(widget.qualidadeAnimada, 'DRI'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(widget.qualidadeAnimada, 'CHU'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(widget.qualidadeAnimada, 'DEF'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(widget.qualidadeAnimada, 'PAS'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(widget.qualidadeAnimada, 'FIS'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _estatisticaWidget(Animation<int> qualidadeJogador, String label) {
    return Row(
      children: [
        UIText.estatistica(qualidadeJogador.value.toString()),
        const SizedBox(width: 5),
        UIText.estatistica(label),
      ],
    );
  }
}