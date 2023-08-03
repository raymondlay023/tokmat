import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/presentation/cubit/product_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late TextEditingController _namaController;
  late TextEditingController _stokController;
  late TextEditingController _hargaController;
  late TextEditingController _modalController;

  @override
  void initState() {
    _namaController = TextEditingController();
    _stokController = TextEditingController();
    _hargaController = TextEditingController();
    _modalController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    _modalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah produk")),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        children: [
          const SizedBox(height: 15),
          CustomTextFormField(
            controller: _namaController,
            labelText: 'Nama',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            controller: _stokController,
            labelText: 'Stok',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            controller: _hargaController,
            labelText: 'Harga',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            controller: _modalController,
            labelText: 'Modal',
          ),
          const SizedBox(height: 45),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: FilledButton(
                onPressed: () => _addProduct(context),
                child: const Text("Tambah")),
          )
        ],
      ),
    );
  }

  void _addProduct(BuildContext context) {
    context
        .read<ProductCubit>()
        .createProduct(ProductEntity(
          name: _namaController.text,
          price: double.tryParse(_hargaController.text),
          capital: double.tryParse(_modalController.text),
          stock: int.tryParse(_stokController.text),
        ))
        .then((_) {
      context.read<ProductCubit>().getProducts();
      Navigator.pop(context);
    });
  }
}
