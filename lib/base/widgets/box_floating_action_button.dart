import 'package:flutter/material.dart';
import 'package:super_equipes/base/widgets/box_icon.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';

class BoxFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? heroTag;
  final IconData? iconData;
  final bool extended;
  final String label;
  
  const BoxFloatingActionButton({
    super.key,
    this.onPressed,
    this.heroTag,
    this.iconData,
    this.extended = false,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return extended
      ? SizedBox(
        height: 51.s3,
        child: FloatingActionButton.extended(
          heroTag: heroTag,
          onPressed: onPressed,
          label: Text(
            label,
            style: fabStyle,
          ),
          icon: BoxIcon(iconData: iconData),
        ),
      ) : isMobile ? 
      FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        child: BoxIcon(iconData: iconData),
      ) : FloatingActionButton.large(
        heroTag: heroTag,
        onPressed: onPressed,
        child: BoxIcon(iconData: iconData),
      );
  }
}
