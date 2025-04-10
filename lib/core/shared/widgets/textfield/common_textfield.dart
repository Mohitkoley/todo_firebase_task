import 'package:flutter/material.dart';
import 'package:todo_firebase/core/shared/common_padding.dart';
import 'package:todo_firebase/core/shared/extension/context_extension.dart';
import 'package:todo_firebase/core/shared/typedef.dart';
import 'package:todo_firebase/core/theme/color_pallete.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.maxLines,
    this.prefixWidget,
    this.onChanged,
    this.prefixText,
    this.suffixWidget,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.filled = false,
    this.contentPadding,
    this.onTapOutside,
    this.enabled,
    this.fillColor,
    this.obscureText,
    this.errorWidget,
    this.changeObsecure,
  }) : assert(
         obscureText != null ? changeObsecure != null : true,
         filled == true ? fillColor != null : true,
       );
  final String hintText;
  final bool filled;
  final Color? fillColor;
  final TextEditingController controller;
  final Validator validator;
  final int? maxLines;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final void Function(String)? onChanged;
  final TextAlign textAlign;
  final String? prefixText;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(PointerDownEvent)? onTapOutside;
  Widget? errorWidget;
  bool? enabled;
  bool? obscureText;
  VoidCallback? changeObsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      textAlign: textAlign,
      enabled: enabled ?? true,
      style: context.bodyLarge.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: obscureText == null || obscureText == false ? 20 : 14,
      ),
      validator: validator,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.disabled,
      keyboardType: keyboardType,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        onTapOutside?.call(event);
      },
      cursorErrorColor: Colors.red,
      obscureText: obscureText ?? false,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        // hintStyle: context.bodyMedium.copyWith(
        //   fontSize: 14,
        //   color: ColorPalette.greyIconColor,
        // ),
        filled: filled,
        fillColor: fillColor,
        prefixText: prefixText,

        prefixIcon: prefixWidget,
        constraints: BoxConstraints(minHeight: 50),
        // prefix: prefixWidget,
        prefixIconConstraints: BoxConstraints(
          maxHeight: 40,
          maxWidth: 40,
          minWidth: 40,
        ),
        hintText: hintText,
        hintStyle: context.bodyMedium.copyWith(
          fontSize: 14,
          color: ColorPalette.buttonDisabledColor,
        ),
        suffixIcon:
            obscureText != null
                ? IconButton(
                  padding: EdgeInsets.only(right: 10),
                  onPressed: () {
                    changeObsecure?.call();
                  },
                  icon: Icon(
                    color: ColorPalette.secondryTextColor,
                    size: 25,
                    obscureText! ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : suffixWidget,
        suffixIconConstraints: BoxConstraints(
          maxHeight: 40,
          minHeight: 30,
          maxWidth: 40,
          minWidth: 30,
        ),
        contentPadding: contentPadding ?? CommonPadding.commonTextFieldPadding,
      ),
    );
  }
}
