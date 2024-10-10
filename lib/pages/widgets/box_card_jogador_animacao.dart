import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';
import 'package:super_equipes/models/enum/tipo_jogador.dart';

class BoxCardJogadorAnimacao extends StatefulWidget {
  final String nome;
  final Animation<int> qualidadeAnimada;
  final TipoJogador tipoJogador;

  const BoxCardJogadorAnimacao({
    super.key,
    required this.nome,
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
      height: 250.s,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.tipoJogador == TipoJogador.goleiro ? Image.asset('assets/images/card_goleiro.png') : Image.asset('assets/images/card_jogador.png'),
            Positioned(
              bottom: 88.s,
              child: UIText.nomeJogador(
                context,
                widget.nome.length > 11 ? '${widget.nome.substring(0, 11)}...' : widget.nome,
              ),
            ),
            Positioned(
              bottom: 35,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(context, widget.qualidadeAnimada, 'VEL'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(context, widget.qualidadeAnimada, 'DRI'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(context, widget.qualidadeAnimada, 'CHU'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(context, widget.qualidadeAnimada, 'DEF'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _estatisticaWidget(context, widget.qualidadeAnimada, 'PAS'),
                      SizedBox(width: 25.s * 0.5),
                      _estatisticaWidget(context, widget.qualidadeAnimada, 'FIS'),
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

  Widget _estatisticaWidget(BuildContext context, Animation<int> qualidadeJogador, String label) {
    return Row(
      children: [
        UIText.estatistica(
          context,
          qualidadeJogador.value.toString(),
        ),
        const SizedBox(width: 5),
        UIText.estatistica(
          context,
          label,
        ),
      ],
    );
  }
}