
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Default for the text form field
class TextFormFieldDefault extends StatelessWidget {
  ///Default for the text form field
  const TextFormFieldDefault({
    super.key,
    this.label,
    required this.controller,
    this.iconMaterial,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.focus,
    this.onEditingComplete,
    this.initialValue,
    this.iconCupertino,
    this.enabled = true,
    this.action = TextInputAction.next,
    this.onTap,
    this.onTapIcon,
    this.selection = true,
    this.onChanged,
    this.maxLines,
    this.textCapitalization,
    this.textInputFormatter,
    this.maxLength,
    this.showCursor,
    this.margin,
    this.suffix,
  });

  ///Controller for the TextForm Field
  final TextEditingController? controller;

  ///textType for the TextForm Field
  final TextInputType? keyboardType;

  ///label for the TextForm Field
  final String? label;

  ///max line in TextForm Field
  final int? maxLines;

  ///iconMaterial for the TextForm Field
  final IconData? iconMaterial;

  ///iconCupertino for the TextForm Field
  final IconData? iconCupertino;

  ///initialValue for the TextForm Field
  final String? initialValue;

  ///obscureText for the TextForm Field
  final bool obscureText;

  ///enabled for the TextForm Field
  final bool? enabled;

  ///enabled for the TextForm Field
  final bool? showCursor;

  ///maxLength for the TextForm Field
  final int? maxLength;

  ///validator for the TextForm Field
  final String? Function(String? value)? validator;

  ///focus for the TextForm Field
  final FocusNode? focus;

  ///onEditingComplete for the TextForm Field
  final Function()? onEditingComplete;

  /// Text Input Formatter
  final List<TextInputFormatter>? textInputFormatter;

  ///action for the TextForm Field
  final TextInputAction action;

  /// Text Capitalization ex: sentences , word
  final TextCapitalization? textCapitalization;

  ///onTap for the TextForm Field
  final Function()? onTap;

  ///onTap for the icon suffix
  final Function()? onTapIcon;

  ///selection for the TextForm Field
  final bool selection;

  ///onChanged for the TextForm Field
  final Function(String)? onChanged;

  ///onChanged for the TextForm Field
  final EdgeInsets? margin;

  ///Suffix widget for the text form field
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Theme.of(context).colorScheme.secondary,
          colorScheme: const ColorScheme.highContrastLight(),
        ),
        child: TextFormField(
          controller:controller,
          validator: validator,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
          decoration: InputDecoration(
            labelText: label,
            isDense: true,
            hintStyle: const TextStyle(
              fontSize: 12.0,
              color: Colors.blue,
            ),
            contentPadding: const EdgeInsets.all(12.0),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),

            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),

            labelStyle: const TextStyle(
              color: Colors.white, // Cor do label
            ),
          ),
          obscureText: obscureText,
          inputFormatters: textInputFormatter,
        ),

      ),
    );
  }
}
