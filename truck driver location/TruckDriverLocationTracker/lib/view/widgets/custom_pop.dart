import 'package:flutter/material.dart';

import '../../size_config.dart';

class CustomPOP {
  popDialog(
    BuildContext context, {
    required Widget title,
    required String desc,
    Color color = Colors.deepOrange,
    bool divider = true,
    bool action = false,
    String txtButton = '',
    Function()? onPress,
    // Function()? onPressCancel,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        content: Wrap(
          children: [
            divider
                ? const Divider(
                    thickness: 1.0,
                  )
                : const SizedBox(),
            SizedBox(
              width: divider ? SizeConfig.screenWidth : null,
              child: Text(
                desc,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: action
            ? [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                  ),
                ),
                TextButton(
                  onPressed: onPress,
                  child: Text(
                    txtButton,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  loadingDialog(context) {
    return popDialog(context,
        divider: false,
        title: const CircularProgressIndicator(color: Colors.deepOrange),
        desc: '');
  }

  loadingWidget() {
    return const Center(
        child: CircularProgressIndicator(color: Colors.deepOrange));
  }
}
