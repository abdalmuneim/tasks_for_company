
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerTextButton extends StatelessWidget {
  final String photographer;
  final double fontSize;
  final String url;

  const CustomerTextButton(
      {Key? key,
      required this.photographer,
      required this.url,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => launcher(context),
      child: Text(
        photographer,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  launcher(BuildContext? context) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched = await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
      if (!launched) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
        );
      }
    } catch (e) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    }
  }
}
