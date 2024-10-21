import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:super_equipes/base/widgets/box_icon.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_helpers.dart';
import 'package:super_equipes/core/theme/ui_helpers/ui_text.dart';

//Classe responsavel por criar um TextField customizado
class BoxTextField extends StatefulWidget {
  final bool enabled;
  final bool isReadOnly;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final String? label;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixicon;
  final Function(String)? onChanged;
  final double? height;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final String? Function(String?)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onFieldSubmitted;
  final String? initialValue;
  final VoidCallback? onPressedSuffixIcon;
  final int maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final bool isPassword;
  final bool isOnTapClear;
  final bool isObservationField;
  final bool enableButtonCleanValue;
  final FocusNode? focusNode;
  final Function()? onPressed;
  

  const BoxTextField({
    super.key,
    this.enabled = true,
    this.isReadOnly = false,
    this.autofocus = false,
    this.autovalidateMode,
    this.label,
    required this.hintText,
    this.prefixIcon,
    this.suffixicon,
    this.onChanged,
    this.height,
    this.contentPadding,
    this.controller,
    this.validatorFunction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialValue,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textCapitalization,
    this.isPassword = false,
    this.isOnTapClear = false,
    this.isObservationField = false,
    this.enableButtonCleanValue = false,
    this.focusNode,
    this.onPressed,
    this.onPressedSuffixIcon,
  });
  
  @override
  State<BoxTextField> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends State<BoxTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.label != null,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10.0.r),
                child: UIText.subtitle(widget.label ?? '', maxLines: 3),
              ),
              SizedBox(height: 5.r),
            ],
          ),
        ),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            autovalidateMode: widget.autovalidateMode,
            enabled: widget.enabled,
            readOnly: widget.isReadOnly,
            autofocus: widget.autofocus,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            initialValue: widget.initialValue,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
            controller: widget.controller,
            validator: widget.validatorFunction,
            inputFormatters: widget.inputFormatters,
            obscureText: _obscureText,
            style: textFieldStyle,
            decoration: InputDecoration(
                counterText: '',
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 2.s),
                  borderRadius: BorderRadius.circular(15.s),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.colorScheme.error, width: 1.s),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.s),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.colorScheme.secondary, width: 1.s),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.s),
                  ),
                ),
                errorStyle: errorStyle,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.colorScheme.secondary, width: 2.s),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.s),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.colorScheme.primary, width: 2.5.s),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.s),
                  ),
                ),
                prefixIcon: widget.prefixIcon != null
                    ? BoxIcon(
                        iconData: widget.prefixIcon,
                      )
                    : null,
                prefixIconConstraints: BoxConstraints.tight(Size(60.s2, 25.s2)),
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        child: BoxIcon(
                          iconData: _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onTap: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      )
                    : widget.enableButtonCleanValue ? 
                    GestureDetector(
                        child: const BoxIcon(
                          iconData: Icons.clear,
                        ),
                        onTap: () => widget.controller!.clear(),
                      ) :
                    GestureDetector(
                        onTap: widget.onPressedSuffixIcon,
                        child: BoxIcon(
                          iconData: widget.suffixicon,
                        ),
                      ),
                suffixIconConstraints: widget.isPassword || widget.enableButtonCleanValue || widget.suffixicon != null ? BoxConstraints.tight(Size(60.s2, 25.s2)) : BoxConstraints.tight(const Size(20, 0)),
                filled: true,
              hintStyle: hintStyle,
              hintText: widget.hintText,
              contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 10.s, vertical: 20.s),
            ),
          ),
        ),
      ],
    );
  }
}
