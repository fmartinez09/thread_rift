import 'package:flutter/material.dart';

class CustomTextFormFieldLabel extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormFieldLabel({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0));

    const borderRadius = Radius.circular(7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 500,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xffEFEFEF),
            borderRadius: BorderRadius.all(
              borderRadius,
            ),
          ),
          child: TextFormField(
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15),
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border.copyWith(
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedErrorBorder: border.copyWith(
                  borderSide: const BorderSide(color: Colors.transparent)),
              isDense: true,
              label: label != null ? Text(label!) : null,
              labelStyle: const TextStyle(color: Color(0xff939393)),
              hintText: hint,
              errorText: null,
              focusColor: colors.primary,
            ),
          ),
        ),
        if (errorMessage != null)
          Container(
            width: 500,
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorMessage!,
              style: const TextStyle(fontSize: 8, color: Colors.red),
            ),
          ),
      ],
    );
  }
}
