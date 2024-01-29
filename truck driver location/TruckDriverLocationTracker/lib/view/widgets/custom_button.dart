import 'package:flutter/material.dart';

import '../../size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    Key? key,
    this.widget,
    this.onPress,
    this.color,
  }) : super(key: key);
  final String text;
  final void Function()? onPress;
  final Widget? widget;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      width: SizeConfig.screenWidth,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith<Color>((states) => color!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
