import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tokmat/domain/entities/user_entity.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';
import 'package:tokmat/presentation/pages/widgets/profile_widget.dart';

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
                      child: profilePhoto(
                          imageUrl: widget.user.profilePhotoUrl, image: _image),
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
                          onPressed: () => _selectImage(),
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
                  onPressed: () {},
                  child: Text('Simpan'),
                ),
              ),
            ],
          )),
    );
  }

  Future _selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No image has been selected");
        }
      });
    } catch (e) {
      toast("Some error occured $e");
    }
  }
}
