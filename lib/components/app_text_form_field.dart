import 'package:flutter/material.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.controller,
    this.textInputAction,
    this.labelText,
    this.keyboardType,
    super.key,
    this.onChanged,
    this.placeholder,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.onEditingComplete,
    this.autofocus,
    this.focusNode,
    this.onFieldSubmitted,
  });

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? labelText;
  final String? placeholder;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      focusNode: focusNode,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      validator: validator,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        fillColor: AppColors.bgLight,
        hintText: placeholder,
        hintStyle: AppTheme.bodyDarkgrey500_16,
        suffixIcon: suffixIcon,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: AppTheme.headingBlack500_16,
    );
  }
}
