import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/injection_container.dart' as di;
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';

class EditShopPage extends StatefulWidget {
  final ShopEntity shop;
  const EditShopPage({super.key, required this.shop});

  @override
  State<EditShopPage> createState() => _EditShopPageState();
}

class _EditShopPageState extends State<EditShopPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.shop.name);
    _phoneNumberController =
        TextEditingController(text: widget.shop.phoneNumber);
    _categoryController = TextEditingController(text: widget.shop.category);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil toko"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
            child: Column(
              children: [
                const SizedBox(height: 25),
                CustomTextFormField(
                  controller: _nameController,
                  labelText: "Nama toko",
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: _phoneNumberController,
                  labelText: "Nomor Telepon",
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: _categoryController,
                  labelText: "Kategori toko",
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _updateShopProfile,
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _updateShopProfile() {
    di
        .sl<ShopCubit>()
        .updateShop(
          ShopEntity(
              name: _nameController.text,
              phoneNumber: _phoneNumberController.text,
              category: _categoryController.text),
        )
        .then((_) {
      context.read<ShopCubit>().getShop();
      Navigator.pop(context);
    });
  }
}
