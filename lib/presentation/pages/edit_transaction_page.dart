import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';
import 'package:tokmat/injection_container.dart' as di;
import '../../core/const.dart';
import '../../domain/entities/cart_entity.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/transaction_cubit.dart';
import 'widgets/cart_tile_widget.dart';

class EditTransactionPage extends StatefulWidget {
  final TransactionEntity transaction;
  const EditTransactionPage({super.key, required this.transaction});

  @override
  State<EditTransactionPage> createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  final List<String> _listType = ["Pemasukan", "Pengeluaran"];
  late String _selectedType;
  late List<CartEntity> _carts;
  late TextEditingController _noteController;
  late TextEditingController _totalController;

  @override
  void initState() {
    _selectedType = widget.transaction.type!.toUpperCase() == "PEMASUKAN"
        ? _listType[0]
        : _listType[1];
    _noteController = TextEditingController(text: widget.transaction.note);
    _totalController =
        TextEditingController(text: widget.transaction.total.toString());
    di.sl<CartCubit>().setCarts(widget.transaction.items!);
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaksi"),
        toolbarHeight: MediaQuery.of(context).size.width / 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            di.sl<CartCubit>().setCarts(List.empty());
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Add/Remove product'),
              onPressed: () =>
                  Navigator.pushNamed(context, PageConst.productPage),
            ),
            const SizedBox(height: 10),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, cartState) {
                if (cartState.status == CartStatus.updated) {
                  _carts = cartState.cartList;
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
                        print(
                            "editTransaction cartList: ${cartState.cartList}");
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
                  _totalController.value =
                      TextEditingValue(text: total.toString());
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
              value: _selectedType,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.category,
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
                _selectedType = value as String;
              }),
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed: () => _editTransaction(),
              child: const Text("Simpan"),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void _editTransaction() {
    di
        .sl<TransactionCubit>()
        .updateTransaction(
          transaction: TransactionEntity(
              id: widget.transaction.id,
              items: _carts,
              note: _noteController.text,
              total: double.tryParse(_totalController.text),
              type: _selectedType),
        )
        .then((_) {
      context.read<TransactionCubit>().getTransactions();
      di.sl<CartCubit>().setCarts(List.empty());
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }
}
