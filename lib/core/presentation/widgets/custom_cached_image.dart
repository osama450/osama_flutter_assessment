// ignore_for_file: public_member_api_docs

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    required this.image,
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.boxFit = BoxFit.cover,
    this.width,
    this.height,
    this.errorWidgetIconScale,
  });
  final String image;
  final BorderRadiusGeometry borderRadius;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final double? errorWidgetIconScale;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: width ?? 100,
        height: height ?? 100,
        child: CachedNetworkImage(
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          filterQuality: FilterQuality.high,
          imageUrl: image,
          fit: boxFit,
          errorWidget: (context, error, stackTrace) {
            return Transform.scale(
              scale: errorWidgetIconScale ?? 0.3,
              child: const Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }
}
