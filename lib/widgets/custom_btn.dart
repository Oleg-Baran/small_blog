import 'package:flutter/material.dart';

class CustButton extends StatefulWidget {
  const CustButton({
    super.key,
    required this.text,
    required this.buttonAction,
  });

  final String text;
  final Function() buttonAction;

  @override
  State<CustButton> createState() => _CustButtonState();
}

class _CustButtonState extends State<CustButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: widget.buttonAction,
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => const Color.fromARGB(255, 230, 210, 32),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}