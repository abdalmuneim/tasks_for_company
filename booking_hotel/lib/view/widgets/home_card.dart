import 'package:flutter/material.dart';

import '../../size_config.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.color, required this.text})
      : super(key: key);
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight / 9,
      width: SizeConfig.screenWidth,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
        BoxShadow(
          color: color,
          offset: const Offset(0.1, 0.4),
          spreadRadius: 2.2,
          blurStyle: BlurStyle.inner,
          blurRadius: 5,
        )
      ]),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).errorColor),
        ),
      ),
    );
  }
}
