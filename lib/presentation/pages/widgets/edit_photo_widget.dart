import 'package:flutter/material.dart';

class EditPhotoWidget extends StatelessWidget {
  final Widget photoWidget;
  final void Function() onPressedCamera;
  final void Function() onPressedGallery;
  const EditPhotoWidget(
      {super.key,
      required this.photoWidget,
      required this.onPressedCamera,
      required this.onPressedGallery});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 150,
          width: 150,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, border: Border.all(width: 1)),
              child: ClipOval(child: photoWidget)),
        ),
        Positioned(
          right: 10,
          bottom: 7,
          child: ClipOval(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: IconButton(
                splashRadius: 0.1,
                color: Theme.of(context).primaryIconTheme.color,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: FilledButton(
                              onPressed: onPressedCamera,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.camera_alt),
                                  Text("Camera"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: FilledButton(
                              onPressed: onPressedGallery,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.photo_size_select_actual_rounded),
                                  Text("Gallery"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                icon: const Icon(Icons.edit),
                iconSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
