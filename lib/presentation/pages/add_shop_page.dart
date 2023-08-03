import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';
import 'package:tokmat/injection_container.dart' as di;

class AddShopPage extends StatefulWidget {
  const AddShopPage({super.key});

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _categoryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah toko")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 30),
            CustomTextFormField(
              labelText: 'Nama toko',
              controller: _nameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 25),
            CustomTextFormField(
              labelText: 'Nomor Telepon',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 25),
            CustomTextFormField(
              labelText: 'Kategori',
              controller: _categoryController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 25),
            FilledButton(
              onPressed: () => _addShop(context),
              child: const Text('Tambah'),
            )
          ],
        ),
      ),
    );
  }

  void _addShop(BuildContext context) {
    context.read<ShopCubit>().createShop(ShopEntity(
          name: _nameController.text,
          phoneNumber: _phoneController.text,
          category: _categoryController.text,
        ));
  }
}
