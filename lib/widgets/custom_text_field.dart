// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import '../util/common.dart';
import '../util/validation.dart';

class CustTextField extends StatefulWidget {
  CustTextField(
      {super.key,
      required this.controller,
      required this.isTextEdited,
      this.isPasswordField = false});

  final TextEditingController controller;
  bool isTextEdited;
  bool isPasswordField;

  @override
  State<CustTextField> createState() => _CustTextFieldState();
}

class _CustTextFieldState extends State<CustTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: Common.getInputDecoration(
          'Password',
          suffixIcon: widget.isPasswordField ? IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            color: Colors.white,
            icon:
                Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
          ) : null,
        ),
        keyboardType: TextInputType.text,
        controller: widget.controller,
        onSaved: (input) => widget.controller.text = input!,
        validator: (v) {
          return widget.isTextEdited ? null : Validation.passwordValidator(v);
        },
        onChanged: (value) {
          widget.isTextEdited = true;
        },
        obscureText: widget.isPasswordField ? hidePassword : false,
      ),
    );
  }
}
