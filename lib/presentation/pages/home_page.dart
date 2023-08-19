import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/presentation/cubit/product_cubit.dart';
import 'package:tokmat/presentation/cubit/shop_cubit.dart';
import 'package:tokmat/presentation/cubit/transaction_cubit.dart';
import 'package:tokmat/presentation/cubit/user_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/Line/my_line_chart.dart';
import 'package:tokmat/presentation/pages/widgets/bar_chart/my_bar_chart.dart';
import 'package:tokmat/presentation/pages/widgets/photo_widget.dart';
import 'package:tokmat/presentation/pages/widgets/pie_chart/my_pie_chart.dart';
import 'package:tokmat/presentation/pages/widgets/small_card_widget.dart';

import '../../core/const.dart';
import '../../domain/entities/transaction_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isSelected = [true, false];
  List<String> options = ['Mingguan', 'Bulanan'];
  late String? _dropdownValue;
  late List<TransactionEntity> transactions;

  @override
  void initState() {
    _dropdownValue = '0';
    transactions = List.empty();
    context.read<ProductCubit>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final shopState = context.watch<ShopCubit>().state;
    final productState = context.watch<ProductCubit>().state;
    final transactionState = context.watch<TransactionCubit>().state;
    transactions = transactionState.transactions;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Builder(builder: (context) {
              return Card(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Halo, ${userState.user.name}!",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text("@${userState.user.username}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.black45)),
                            ],
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ClipOval(
                              child: photoWidget(
                                  defaultImage:
                                      OtherConst.defaultProfileImagePath,
                                  imageUrl: userState.user.profilePhotoUrl),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "${shopState.shop.name}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Halaman Dasbor',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ToggleButtons(
                    borderRadius: BorderRadius.circular(12),
                    isSelected: isSelected,
                    onPressed: (newIndex) {
                      setState(() {
                        for (var index = 0;
                            index < isSelected.length;
                            index++) {
                          if (index == newIndex) {
                            isSelected[index] = true;
                          } else {
                            isSelected[index] = false;
                          }
                        }
                      });
                    },
                    children: options
                        .map(
                          (option) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(option),
                          ),
                        )
                        .toList()),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Flexible(
                  child: SmallCardWidget(
                    prefixIcon: const Icon(
                      Icons.insert_chart,
                      size: 30,
                    ),
                    title: formatCurrency(
                        sumTotalOfTransactions(transactions: transactions)),
                    subtitle: "Total Transaksi",
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  child: SmallCardWidget(
                    prefixIcon: const Icon(
                      Icons.show_chart,
                      size: 30,
                    ),
                    title: formatCurrency(
                        countAvgOfTransactions(transactions: transactions)),
                    subtitle: "Rerata Transaksi",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            showChart(
              isWeekly: isSelected[0],
              isMonthly: isSelected[1],
            ),
            const SizedBox(height: 25),
            Card(
              child: SizedBox(
                height: 400,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 15, right: 20, left: 20),
                        child: Wrap(
                          children: [
                            Text(
                              "Produk-produk yang stoknya menipis",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 2),
                    Expanded(
                      flex: 4,
                      child: Builder(builder: (context) {
                        final products = productState.products;
                        final productsWithLowestStocks =
                            getProductsWithLowestAmount(products, 10);
                        return ListView.builder(
                          itemCount: productsWithLowestStocks.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(productsWithLowestStocks[index]
                                  .name
                                  .toString()),
                              subtitle: Text(formatCurrency(
                                  productsWithLowestStocks[index].price)),
                              trailing: Text(
                                  "Stok tersisa : ${productsWithLowestStocks[index].stock} item"),
                              leading: SizedBox(
                                height: 20,
                                width: 20,
                                child: photoWidget(
                                    defaultImage:
                                        OtherConst.defaultProductImagePath,
                                    imageUrl: productsWithLowestStocks[index]
                                        .productPhotoUrl),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Card(
                child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "Persentase Pemasukan dan Pengeluaran",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    height: 300, child: MyPieChart(transactions: transactions)),
              ],
            )),
            const SizedBox(height: 25),
          ],
        ),
      ),
    ));
  }

  Widget showChart({
    bool isWeekly = false,
    bool isMonthly = false,
  }) {
    if (isWeekly) {
      List<List<TransactionEntity>> groupedTransactions =
          groupTransactionByWeek(
              DateTime.now().year, DateTime.now().month, transactions);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DropdownButton(
            value: _dropdownValue,
            items: [
              for (int index = 0; index < groupedTransactions.length; index++)
                DropdownMenuItem(
                  value: "$index",
                  child: Text("Minggu ke-${index + 1}"),
                )
            ],
            onChanged: (selectedValue) {
              setState(() {
                _dropdownValue = selectedValue;
              });
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 200,
            child: MyBarChart<TransactionEntity>(
              objects: groupedTransactions[int.parse(_dropdownValue!)],
              getTotal: (object) => object.total!,
            ),
          ),
        ],
      );
    } else if (isMonthly) {
      return SizedBox(
          height: 200, child: MyLineChart(transactions: transactions));
    } else {
      return const Text('Chart Error!');
    }
  }
}
