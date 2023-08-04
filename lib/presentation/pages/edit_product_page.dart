import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/injection_container.dart' as di;
import '../../core/utils.dart';
import '../../domain/usecases/upload_image_to_storage_usecase.dart';
import '../cubit/product_cubit.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/edit_photo_widget.dart';
import 'widgets/photo_widget.dart';

class EditProductPage extends StatefulWidget {
  final ProductEntity product;
  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _namaController;
  late TextEditingController _stokController;
  late TextEditingController _hargaController;
  late TextEditingController _modalController;
  File? _image;

  @override
  void initState() {
    _namaController = TextEditingController(text: widget.product.name);
    _stokController =
        TextEditingController(text: widget.product.stock.toString());
    _hargaController =
        TextEditingController(text: widget.product.price.toString());
    _modalController =
        TextEditingController(text: widget.product.capital.toString());
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
      appBar: AppBar(
        title: const Text("Edit Produk"),
        actions: [
          IconButton(
            onPressed: () => _deleteProduct(),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Column(
            children: [
              EditPhotoWidget(
                onPressedCamera: () {
                  _selectImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                onPressedGallery: () {
                  _selectImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                photoWidget: photoWidget(
                  imageUrl: widget.product.productPhotoUrl,
                  defaultImage: 'assets/default-product-picture.png',
                  selectedImage: _image,
                ),
              ),
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
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
                    onPressed: () => _image == null
                        ? _editProduct()
                        : _editProductWithImage(),
                    child: const Text("Edit")),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deleteProduct() {
    context.read<ProductCubit>().deleteProduct(widget.product.id!).then((_) {
      context.read<ProductCubit>().getProducts();
      Navigator.pop(context);
    });
  }

  void _editProductWithImage() {
    di
        .sl<UploadImageToStorageUseCase>()
        .call(_image!, "products", true)
        .then((imageUrl) => _editProduct(imageUrl: imageUrl));
  }

  void _editProduct({String imageUrl = ""}) {
    print("_editProduct id :${widget.product.id}");
    context
        .read<ProductCubit>()
        .updateProduct(ProductEntity(
          id: widget.product.id,
          name: _namaController.text,
          price: double.tryParse(_hargaController.text),
          capital: double.tryParse(_modalController.text),
          stock: int.tryParse(_stokController.text),
          productPhotoUrl: imageUrl,
        ))
        .then((_) {
      context.read<ProductCubit>().getProducts();
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
