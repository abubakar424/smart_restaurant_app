import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double? textSize;
  final double? letterSpacing;
  final double? borderRadius;
  final double? elevation;
  final Color? textColor;
  final FontWeight? fontWeight;
  final List<Color>? gradientColors;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final IconData? icon;
  final Widget? iconWidget;
  final double? iconSize;
  final Color? iconColor;
  final bool isIconRight;
  final Color? borderColor;
  final double? borderWidth;
  final bool isDisabled; // Added isDisabled parameter

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.elevation,
    this.iconWidget,
    this.textColor,
    this.fontWeight,
    this.textSize,
    this.letterSpacing,
    this.borderRadius,
    this.gradientColors,
    this.color,
    this.padding,
    this.width,
    this.height,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.isIconRight = false,
    this.borderColor,
    this.borderWidth,
    this.isDisabled =
        false,  bool? isLoading, // Initialize isDisabled with a default value of false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      width: width ?? MediaQuery.sizeOf(context).width * 0.7,
      child: ElevatedButton(
        onPressed: isDisabled
            ? null
            : onTap, // Disable the button when isDisabled is true
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            side: borderColor != null
                ? BorderSide(
                    color: borderColor!,
                    width: borderWidth ?? 1.0,
                  )
                : BorderSide.none,
          ),
          elevation: elevation ?? 0,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: isDisabled
                ? colorScheme(context)
                    .outlineVariant // Use outlineVariant when disabled
                : color ??
                    colorScheme(context)
                        .primary, // Use primary color when not disabled
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                    width: borderWidth ?? 1.0,
                  )
                : null,
          ),
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: isIconRight
                ? _buildTextWithIcon(context)
                : _buildIconWithText(context),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          iconWidget ??
              Icon(
                icon,
                size: iconSize ?? 20,
                color: iconColor ??
                    (isDisabled
                        ? colorScheme(context)
                            .outline // Adjust icon color when disabled
                        : colorScheme(context).onPrimary),
              ),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: GoogleFonts.sora(
            color: isDisabled
                ? colorScheme(context)
                    .outline // Adjust text color when disabled
                : textColor ?? colorScheme(context).onPrimary,
            fontWeight: fontWeight ?? FontWeight.w700,
            fontSize: textSize ?? 17,
            letterSpacing: letterSpacing ?? 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildTextWithIcon(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null || iconWidget != null) ...[
          const SizedBox(width: 8),
          iconWidget ??
              Icon(
                icon,
                size: iconSize ?? 20,
                color: iconColor ??
                    (isDisabled
                        ? colorScheme(context)
                            .outline // Adjust icon color when disabled
                        : colorScheme(context).onPrimary),
              ),
        ],
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: GoogleFonts.sora(
            color: isDisabled
                ? colorScheme(context)
                    .outline // Adjust text color when disabled
                : textColor ?? colorScheme(context).onPrimary,
            fontWeight: fontWeight ?? FontWeight.w700,
            fontSize: textSize ?? 14,
          ),
        ),
      ],
    );
  }
}
