import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      size: size ?? 22.sp,
      color: color,
      iconData,
    );
  }
}
