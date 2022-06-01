import 'package:act_steel_frontend/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedImage(String url, {double width = 100, double height = 100}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    fit: BoxFit.cover,
    placeholder: (context, url) =>
        Loading(color: const AlwaysStoppedAnimation<Color>(Colors.grey)),
    errorWidget: (context, url, error) => Icon(Icons.error),
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle),
    ),
  );
}
