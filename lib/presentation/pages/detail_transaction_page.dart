import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';

import '../../core/theme.dart';

class DetailTransactionPage extends StatelessWidget {
  final TransactionEntity transaction;
  const DetailTransactionPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Transaksi',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            splashRadius: 25,
            icon: const Icon(Icons.mode_edit),
            onPressed: () => Navigator.pushNamed(
              context,
              PageConst.editTransactionPage,
              arguments: transaction,
            ),
          ),
          IconButton(
            splashRadius: 25,
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Builder(builder: (context) {
                final shopState = context.watch<ShopCubit>().state;
                final isSuccess = shopState.status == ShopStatus.success;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${isSuccess ? shopState.shop.name : 'Belum ada nama toko'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${isSuccess ? shopState.shop.phoneNumber : 'Belum ada nomor hp'}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
              const SizedBox(height: 30),
              Text(DateFormat('EEEE, MMM d, yyyy')
                  .format(transaction.createdAt!.toDate())),
              const SizedBox(height: 10),
              Text("Tipe : ${transaction.type}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: transaction.type == TypeConst.pengeluaran
                          ? pengeluaranColor
                          : pemasukanColor)),
              const SizedBox(height: 10),
              const DottedLine(),
              const SizedBox(height: 15),
              // Header
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Nama Barang',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Jumlah',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Subtotal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 0.5,
                color: Colors.black.withOpacity(0.5),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: transaction.items!
                          .map((item) => Column(
                                children: [
                                  Text('${item.product.name}'),
                                  Text(
                                    '${formatCurrency(item.product.price)} / item',
                                    style: const TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: transaction.items!
                          .map((item) => Column(
                                children: [
                                  Text("${item.quantity}"),
                                  const SizedBox(height: 25),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: transaction.items!
                          .map((item) => Column(
                                children: [
                                  Text(formatCurrency(
                                      item.product.price! * item.quantity)),
                                  const SizedBox(height: 25),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const DottedLine(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Total Transaksi',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      formatCurrency(transaction.total!),
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Catatan :',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${transaction.note}',
                    style: const TextStyle(fontSize: 15, color: Colors.black45),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
