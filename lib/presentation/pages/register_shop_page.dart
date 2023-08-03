import 'package:flutter/material.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';

import '../../core/theme.dart';

class RegisterShopPage extends StatefulWidget {
  const RegisterShopPage({super.key});

  @override
  State<RegisterShopPage> createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _categoryController = TextEditingController();
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Image.asset(
                'assets/tokmat-logo.png',
                height: 180,
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Usaha',
                    style: headerTextStyle,
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Nama Usaha',
                    hintText: 'Masukkan username Anda disini',
                  ),
                  const SizedBox(height: 35),
                  CustomTextFormField(
                    controller: _categoryController,
                    labelText: 'Kategori Usaha',
                    hintText: 'Masukkan email Anda disini',
                  ),
                  const SizedBox(height: 35),
                  CustomTextFormField(
                    controller: _phoneNumberController,
                    labelText: 'Nomor Handphone',
                    hintText: 'Masukkan password Anda disini',
                    isPasswordField: true,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // SizedBox(
              //   width: double.infinity,
              //   child: FilledButton(
              //     onPressed: () => _registerShop(),
              //     child: registerShopState
              //         ? Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: CircularProgressIndicator(
              //               color: Theme.of(context).indicatorColor,
              //             ),
              //           )
              //         : Text('Daftar Toko'),
              //   ),
              // ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void _registerShop() {
    // TODO: Implement register shop
  }

  void _clear() {
    _nameController.clear();
    _categoryController.clear();
    _phoneNumberController.clear();
  }
}
