import 'package:flutter/cupertino.dart';
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
    this.obscure = false,
  }) : super(key: key);
  final onSaved;
  final onChanged;
  final validator;
  final bool obscure;
  final TextInputType? boardType;
  final String label;
  final String? hint;


  @override
  Widget build(BuildContext context) {
    return buildTextFormField();
  }

  buildTextFormField() {
    return TextFormField(
      obscureText: obscure,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (val) => validator(val),
      keyboardType: boardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(fontSize: 18, color: Colors.blue,overflow: TextOverflow.visible),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
            left: 15,
            top: 8,
            right: 15,
            bottom: 0
        ),
        label: Text(
          label,
        ),
        hintText: hint,

      ),
    );
  }
}
