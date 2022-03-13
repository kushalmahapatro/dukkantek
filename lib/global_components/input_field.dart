import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/global_components/text/text_styles.dart';

class DTInputText extends HookWidget {
  const DTInputText({
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.labelSuffixwidget,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.prefix,
    this.suffix,
    this.inputType,
    this.maxLength,
    this.obscure = false,
    this.focusNode,
    this.readOnly = false,
    this.error,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final Widget? labelSuffixwidget;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? inputType;
  final TextEditingController controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool obscure;
  final FocusNode? focusNode;
  final String? error;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return textField(normalDecoration);
  }

  InputDecoration get normalDecoration => InputDecoration(
        // contentPadding: EdgeInsets.zero,
        label: labelText.text.bodySmall().make(),
        hintText: hintText,
        suffixIcon: suffix,
        counterText: '',
      );

  TextFormField textField(InputDecoration decoration) {
    return TextFormField(
      cursorColor: DTColors.secondary,
      style: bodyMediumStyle(DTColors.primary),
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      decoration: decoration,
      maxLength: maxLength,
      keyboardType: inputType,
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      obscureText: obscure,
    );
  }
}
