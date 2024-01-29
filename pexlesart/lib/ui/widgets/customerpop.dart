import 'package:flutter/material.dart';
import 'package:pexlesart/ui/widgets/some_widgets.dart';

import 'navigator.dart';

class CustomerPOP {

  popDialog(context,
      {required Widget title, required String desc, List<Widget>? action}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: title,
          content: Text(desc),
          actions: action,
        ));
  }

  // loadingWidget(context) {
    // return popDialog(context,
        // title:
            // LoadingAnimationWidget.hexagonDots(size: 30, color: Colors.black),
        // desc: '');
  // }

  handleErrors(BuildContext context, String desc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Column(
                children: [
                  triExclamenation(),
                  const Divider(),
                ],
              ),
              content: Text(desc),
              actions: [
                TextButton(
                  onPressed: () => NavigatorScreen().pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ));
  }
}
