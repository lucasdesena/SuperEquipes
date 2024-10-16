import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/responsivity.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

class BoxListaVazia extends StatelessWidget{
  const BoxListaVazia({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/lista_vazia.png', height: 200.s4c, fit: BoxFit.contain,),
            SizedBox(height: 15.s),
            UIText.tituloImagem('Lista de jogadores vazia'),
            SizedBox(height: 4.s),
            UIText.subTituloImagem('Nenhum jogador cadastrado'),
            SizedBox(height: 15.s),
          ],
        ),
      ),
    );
  }
}