import 'package:flutter/material.dart';

class NovoJogadorPage extends StatefulWidget {
  const NovoJogadorPage({super.key});

  @override
  State<NovoJogadorPage> createState() => _NovoJogadorPageState();
}

class _NovoJogadorPageState extends State<NovoJogadorPage> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (orientationContext, orientation) {
        return const Scaffold(
          body: Center(),
        );
      }
    );
  }
}