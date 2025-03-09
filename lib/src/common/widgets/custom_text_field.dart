import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/global_variables.dart';

class CustomTextFormField extends StatelessWidget {
  final int? maxline;
  final int? maxLength;
  final double? height;
  final double? hintSize;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final EdgeInsetsGeometry? contentPadding;
  final String? hint;
  final String? labelText;
  final String? initialValue;
  final bool? obscureText;
  final bool? filled;
  final bool? isCollapsed;
  final bool? isDense;
  final bool? isEnabled;
  final bool? readOnly;
  final bool? enableBorder;
  final Color? fillColor;
  final Color? hintColor;
  final Color? inputColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? prefixConstraints;
  final BoxConstraints? suffixConstraints;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputDecoration? customDecoration;
  final String? semanticLabel;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Added validator parameter
  const CustomTextFormField({
    super.key,
    this.maxline,
    this.maxLength,
    this.height,
    this.hintSize,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.contentPadding,
    this.hint,
    this.labelText,
    this.initialValue,
    this.obscureText,
    this.filled = true,
    this.isCollapsed,
    this.isDense,
    this.isEnabled,
    this.readOnly,
    this.fillColor,
    this.hintColor,
    this.inputColor,
    this.borderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixConstraints,
    this.suffixConstraints,
    this.focusNode,
    this.keyboardType,
    this.inputAction,
    this.autoValidateMode,
    this.textStyle,
    this.enableBorder = true,
    this.errorTextStyle,
    this.customDecoration,
    this.semanticLabel,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.controller,
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      cursorColor: cursorColor,
      maxLines: (obscureText ?? false)
          ? 1
          : (maxline ?? 1), 
      textInputAction: inputAction,
      initialValue: initialValue,
      style: textStyle ?? textTheme(context).bodyMedium,
      autofocus: false,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      readOnly: readOnly ?? false,
      enabled: isEnabled ?? true,
      decoration: customDecoration ??
          InputDecoration(
            labelText: labelText,
            counterText: '',
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: hintColor ?? colorScheme(context).outline,
              fontSize: hintSize ?? 14,
            ),
            filled: filled ?? false,
            fillColor: fillColor ?? colorScheme(context).surface,
            prefixIconConstraints: prefixConstraints,
            suffixIconConstraints: suffixConstraints,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: horizontalPadding ?? 18.0,
                  vertical: verticalPadding ?? 17,
                ),
            errorStyle: errorTextStyle,
            errorMaxLines: 2,
            isCollapsed: isCollapsed ?? false,
            isDense: isDense,
            enabledBorder: enableBorder == true ? OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? colorScheme(context).outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ) : null,
            focusedBorder: enableBorder == true ? OutlineInputBorder(
              borderSide: BorderSide(
                color: focusBorderColor ??
                    colorScheme(context).outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ) : null,
            errorBorder: enableBorder == true ? OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).error.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ) : null,
            focusedErrorBorder: enableBorder == true ? OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).error.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ): null,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme(context).outline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ),
          ),
      validator:   validator,
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: onTapOutside ??
          (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
    );
  }

  

}
