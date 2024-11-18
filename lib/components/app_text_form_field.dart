part of '../core_library.dart';

/// A customizable text form field widget with consistent styling.
///
/// The [AppTextFormField] is a wrapper around Flutter's [TextFormField],
/// providing predefined styling and commonly used configurations throughout the app.
///
/// ### Example Usage
/// ```dart
/// AppTextFormField(
///   controller: myController,
///   placeholder: 'Enter your name',
///   keyboardType: TextInputType.text,
/// );
/// ```
/// {@category Core}
class AppTextFormField extends StatelessWidget {
  /// Creates an [AppTextFormField].
  ///
  /// - [controller]: The [TextEditingController] for managing the input text.
  /// - [textInputAction]: Specifies the action button on the keyboard (e.g., next, done).
  /// - [labelText]: The label text displayed above the input when focused.
  /// - [keyboardType]: The type of keyboard to use for the input.
  /// - [onChanged]: Callback for when the text changes.
  /// - [placeholder]: The placeholder text displayed when the input is empty.
  /// - [validator]: The validator function for form validation.
  /// - [obscureText]: Whether to obscure the input text (useful for passwords).
  /// - [suffixIcon]: An icon displayed at the end of the input field.
  /// - [onEditingComplete]: Callback when editing is complete.
  /// - [autofocus]: Whether to focus this input field automatically.
  /// - [focusNode]: The [FocusNode] for managing focus.
  /// - [onFieldSubmitted]: Callback when the field is submitted.
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

  /// Callback for when the text changes.
  final void Function(String)? onChanged;

  /// Validator function for form validation.
  final String? Function(String?)? validator;

  /// Specifies the action button on the keyboard (e.g., next, done)
  final TextInputAction? textInputAction;

  /// The type of keyboard to use for the input.
  final TextInputType? keyboardType;

  /// Controller for managing the input text.
  final TextEditingController controller;

  /// Whether to obscure the input text (useful for passwords).
  final bool? obscureText;

  /// An icon displayed at the end of the input field.
  final Widget? suffixIcon;

  /// The label text displayed above the input when focused.
  final String? labelText;

  /// The placeholder text displayed when the input is empty.
  final String? placeholder;

  /// Whether to focus this input field automatically.
  final bool? autofocus;

  /// The [FocusNode] for managing focus.
  final FocusNode? focusNode;

  /// Callback when editing is complete.
  final void Function()? onEditingComplete;

  /// Callback when the field is submitted.
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
        hintStyle: AppTheme.darkGrey500_16,
        suffixIcon: suffixIcon,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: AppTheme.black500_16,
    );
  }
}
