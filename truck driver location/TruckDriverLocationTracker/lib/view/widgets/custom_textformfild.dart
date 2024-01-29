import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    Key? key,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.boardType = TextInputType.text,
    required this.label,
    this.hint = '',
    this.prefixIcon,
    this.suffixIcon,
    this.onPressedPrefix,
    this.obscure = false,
    this.maxLength,
    this.inputFormatters,
    this.suffixIconColor = Colors.black,
  }) : super(key: key);
  final onSaved;
  final onChanged;
  final validator;
  final bool obscure;
  final TextInputType? boardType;
  final String label;
  final String? hint;
  final void Function()? onPressedPrefix;
  final IconData? prefixIcon;
  final int? maxLength;
  final suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Color? suffixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      obscureText: obscure,
      onSaved: onSaved,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      validator: (val) => validator(val),
      keyboardType: boardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: Text(
          label,
        ),
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: Colors.deepOrange),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          width: 1,
          color: Colors.deepOrange,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          width: 1,
          color: Colors.deepOrange,
        )),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          width: 1,
          color: Colors.deepOrange,
        )),
        prefixIcon: Icon(prefixIcon, color: Colors.deepOrange, size: 25),
        prefix: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        suffixIcon: IconButton(
          onPressed: onPressedPrefix,
          icon: Icon(suffixIcon, size: 25),
          color: suffixIconColor,
        ),
      ),
    );
  }
}
