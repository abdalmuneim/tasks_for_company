import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petro_one/generated/assets/assets.dart';

class CacheNetworkImage extends StatelessWidget {
  const CacheNetworkImage({
    super.key,
    required this.url,
    this.borderRadius = 100,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
  });
  final String? url;
  final double borderRadius;
  final BoxFit? fit;
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: url!,
          width: width,
          height: height,
          fit: fit,
          errorWidget: (BuildContext context, _, stackTrace) {
            return Image.asset(Assets.assetsImagesPngFavicon);
          },
          progressIndicatorBuilder:
              (context, String url, DownloadProgress progress) {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
