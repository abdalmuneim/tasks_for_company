import 'package:flutter/material.dart';

import '../../size_config.dart';

class CustomerImageNetWork extends StatelessWidget {
  const CustomerImageNetWork({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, _, stackTrace) =>
          const Icon(Icons.error),
      loadingBuilder: (context, Widget child, ImageChunkEvent? url) {
        if (url == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
              value: url.expectedTotalBytes != null
                  ? url.cumulativeBytesLoaded / url.expectedTotalBytes!
                  : null,
            ),
          );
        }
      },
    );
  }

  imageViewer(context,{required String url}){
    return NetworkImage(url,);
  }
}
