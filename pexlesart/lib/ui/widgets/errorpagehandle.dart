import 'package:flutter/material.dart';

class ErrorScreenHandle extends StatelessWidget {
  const ErrorScreenHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        'Have ERROR: ',
        style: TextStyle(
          color: Colors.red,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
