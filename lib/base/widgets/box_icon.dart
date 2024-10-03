import 'package:flutter/material.dart';
import 'package:super_equipes/core/theme/responsivity.dart';

class BoxIcon extends StatelessWidget {
  final Color? color;
  final IconData? iconData;
  final double? size;

  const BoxIcon({
    super.key,
    this.color,
    this.iconData, 
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      size: size ?? 22.s2,
      color: color,
      iconData,
    );
  }
}
