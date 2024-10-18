import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

class BoxPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  const BoxPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      backgroundColor: color ?? Get.theme.colorScheme.tertiary,
    ),
      onPressed: onPressed,
      child: UIText.buttonPrimary(text),
    );
  }
}
