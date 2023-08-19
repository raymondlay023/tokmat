import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/cart_entity.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/cubit/cart_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/cart_tile_widget.dart';
import 'package:tokmat/presentation/pages/widgets/custom_text_form_field.dart';
import 'package:tokmat/injection_container.dart' as di;

import '../cubit/transaction_cubit.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final List<String> _listType = [TypeConst.pemasukan, TypeConst.pengeluaran];
  late String _selectedType;
  late DateTime _date;
  late List<CartEntity> _carts;
  late TextEditingController _noteController;
  late TextEditingController _totalController;

  @override
  void initState() {
    _selectedType = _listType[0];
    _date = DateUtils.dateOnly(DateTime.now());
    _noteController = TextEditingController();
    _totalController = TextEditingController();
    di.sl<CartCubit>().setCarts(List.empty());
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
        title: const Text("Tambah Transaksi"),
        toolbarHeight: MediaQuery.of(context).size.width / 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            OutlinedButton(
              child: const Text('Tambah produk'),
              onPressed: () =>
                  Navigator.pushNamed(context, PageConst.productPage),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => pickDate(),
              child: Ink(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${_date.day}/${_date.month}/${_date.year}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
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
              onPressed: () => _addTransaction(),
              child: const Text("Tambah"),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Future pickDate() async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    print("date $_date");
    if (newDate == null) return;
    setState(() {
      _date = newDate;
    });
    print("date $_date");
  }

  void _addTransaction() {
    di
        .sl<TransactionCubit>()
        .createTransaction(
            transaction: TransactionEntity(
          items: _carts,
          note: _noteController.text,
          total: double.tryParse(_totalController.text),
          type: _selectedType,
          createdAt: Timestamp.fromDate(_date),
        ))
        .then((_) {
      context.read<TransactionCubit>().getTransactions();
      Navigator.pop(context);
    });
  }
}
