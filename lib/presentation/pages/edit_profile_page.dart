import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/domain/usecases/upload_image_to_storage_usecase.dart';
import 'package:tokmat/presentation/cubit/user_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';
import 'package:tokmat/presentation/pages/widgets/photo_widget.dart';
import 'package:tokmat/injection_container.dart' as di;
import '../../core/utils.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  File? _image;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user.name);
    _usernameController = TextEditingController(text: widget.user.username);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 150,
                    child: ClipOval(
                      child: photoWidget(
                        imageUrl: widget.user.profilePhotoUrl,
                        image: _image,
                      ),
                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: FilledButton(
                                        onPressed: () {
                                          _selectImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
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
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: FilledButton(
                                        onPressed: () {
                                          _selectImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons
                                                .photo_size_select_actual_rounded),
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
              ),
              const SizedBox(height: 25),
              CustomTextFormField(
                controller: _nameController,
                labelText: "Name",
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _usernameController,
                labelText: "Username",
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _image == null
                      ? _updateProfile()
                      : _updateProfileWithImage(),
                  child: Text('Simpan'),
                ),
              ),
            ],
          )),
    );
  }

  void _updateProfileWithImage() {
    di
        .sl<UploadImageToStorageUseCase>()
        .call(_image!, "profileImages", true)
        .then((imageUrl) => _updateProfile(imageUrl: imageUrl));
  }

  void _updateProfile({String imageUrl = ""}) {
    di
        .sl<UserCubit>()
        .updateUser(UserEntity(
            username: _usernameController.text,
            name: _nameController.text,
            profilePhotoUrl: imageUrl))
        .then((_) {
      context.read<UserCubit>().getUser();
      Navigator.pop(context);
    });
  }

  Future _selectImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } on PlatformException catch (e) {
      // Debug
      print("Pick image error: $e");
      toast("Failed to pick image !");
    }
  }
}
