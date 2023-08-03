import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget profilePhoto({String? imageUrl, File? image}) {
  if (image == null) {
    if (imageUrl == null || imageUrl == "") {
      return Image.asset(
        'assets/default-profile-picture.png',
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) =>
            CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset(
          'assets/default-profile-picture.png',
          fit: BoxFit.cover,
        ),
      );
    }
  } else {
    return Image.file(image, fit: BoxFit.cover);
  }
}
