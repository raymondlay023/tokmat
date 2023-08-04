import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/cubit/cart_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/cart_tile_widget.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';
import 'package:tokmat/injection_container.dart' as di;
import 'package:uuid/uuid.dart';

import '../cubit/transaction_cubit.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final List<String> _listType = ["Pemasukan", "Pengeluaran"];
  late String _selectedValue;
  late TextEditingController _idController;
  late TextEditingController _noteController;
  late TextEditingController _totalController;

  @override
  void initState() {
    _selectedValue = _listType[0];
    _idController = TextEditingController();
    _noteController = TextEditingController();
    _totalController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Transaksi"),
        toolbarHeight: MediaQuery.of(context).size.width / 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Add product'),
              onPressed: () =>
                  Navigator.pushNamed(context, PageConst.productPage),
            ),
            const SizedBox(height: 10),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, cartState) {
                if (cartState.status == CartStatus.updated) {
                  final cartLength = cartState.cartList.length;
                  final height = MediaQuery.of(context).size.height;
                  return SizedBox(
                    height: cartLength == 0
                        ? 0
                        : cartLength <= 1
                            ? height / 7
                            : cartLength <= 2
                                ? height / 4
                                : height / 3.25,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartState.cartList.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartState.cartList[index];
                        print("addTransaction cartList: ${cartState.cartList}");
                        return CartTileWidget(cart: cartItem);
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              controller: _noteController,
              prefixIcon: const Icon(Icons.description),
              labelText: 'Keterangan',
              hintText: 'Masukkan keterangan transaksi',
            ),
            const SizedBox(height: 15),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, cartState) {
                if (cartState.status == CartStatus.updated) {
                  final total = di.sl<CartCubit>().getTotal();
                  _totalController =
                      TextEditingController(text: total.toString());
                }
                return CustomTextFormField(
                  controller: _totalController,
                  prefixIcon: const Icon(Icons.attach_money),
                  labelText: 'Total',
                  hintText: 'Masukkan total transaksi',
                  keyboardType: TextInputType.number,
                );
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Theme.of(context).primaryColor,
              ),
              value: _selectedValue,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.type_specimen,
                  color: Theme.of(context).primaryColor,
                ),
                border: const OutlineInputBorder(),
              ),
              items: _listType
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) => setState(() {
                _selectedValue = value as String;
              }),
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed: () {
                di.sl<TransactionCubit>().createTransaction(
                        transaction: TransactionEntity(
                      id: _idController.text.isNotEmpty
                          ? _idController.text
                          : Uuid().v1(),
                      note: _noteController.text,
                      total: double.tryParse(_totalController.text),
                    ));
              },
              child: const Text("Tambah"),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
