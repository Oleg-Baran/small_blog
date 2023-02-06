import 'package:flutter/material.dart';

class Common {
  static InputDecoration getInputDecoration(String hintText, {suffixIcon}) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));
    const borderWidthValue = 1.0;

    const errorBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: Colors.red, width: borderWidthValue),
    );

    const defaultBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: Colors.white, width: borderWidthValue),
    );

    return InputDecoration(
      errorMaxLines: 3,
      errorStyle: const TextStyle(color: Colors.red),
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder,
      border: defaultBorder,
      focusedErrorBorder: errorBorder,
      errorBorder: errorBorder,
      filled: true,
      hintStyle: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
      suffixIcon: suffixIcon,
    );
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).unfocus();
  }

  static void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color.fromARGB(225, 255, 255, 255),
        contentPadding: const EdgeInsets.only(top: 10),
        title: const Text(
          'An error occurred',
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        actions: [
          MaterialButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
