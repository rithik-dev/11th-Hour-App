import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final bool infinity;
  CachedImage({this.url, this.infinity = true});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: infinity ? double.infinity : 125.0,
      height: double.infinity,
      imageUrl: url,
      placeholder: (context, _) => Shimmer.fromColors(
        child: Container(
          width: double.infinity,
        ),
        baseColor: Colors.white,
        highlightColor: Colors.grey[300],
      ),
    );
  }
}
