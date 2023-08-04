import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget photoWidget(
    {String? imageUrl, File? selectedImage, required String defaultImage}) {
  if (selectedImage == null) {
    if (imageUrl == null || imageUrl == "") {
      return Image.asset(
        defaultImage,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, progress) =>
              const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error));
    }
  } else {
    return Image.file(selectedImage, fit: BoxFit.cover);
  }
}
