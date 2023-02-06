import 'package:flutter/material.dart';

class CustProgress extends StatelessWidget {
  const CustProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      ),
    );
  }
}
