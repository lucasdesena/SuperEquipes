
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

///Cria um dropdown customizado
class BoxDropdown extends StatelessWidget {
  final Function(dynamic)? onChanged;
  final dynamic initialValue;
  final List<DropdownMenuItem<Object>> items;
  final String? label;
  final Function()? onTap;
  final String? Function(dynamic)? validator;

  const BoxDropdown({
    super.key,
    required this.onChanged,
    required this.initialValue,
    required this.items,
    this.label,
    this.onTap, 
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: label != null,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 10.0.r),
            child: UIText.subtitle(label ?? ''),
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<dynamic>(
          iconSize: 22.s2,
          itemHeight: kMinInteractiveDimension.s2c,
          onTap: onTap,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20.s2),
            filled: true,
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 2.s),
              borderRadius: BorderRadius.circular(15.s),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 1.s),
              borderRadius: BorderRadius.circular(15.s),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.secondary, width: 2.s),
              borderRadius: BorderRadius.circular(15.s),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.primary, width: 2.5.s),
              borderRadius: BorderRadius.circular(15.s),
            ),
          ),
          onChanged: onChanged,
          value: initialValue,
          items: items,
          validator: validator,
        ),
      ],
    );
  }
}
