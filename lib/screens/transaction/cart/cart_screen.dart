import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/controllers/order.dart';
import 'package:lentera_ilmu/models/lms/cart.dart';
import 'package:lentera_ilmu/screens/navigation.dart';
import 'package:lentera_ilmu/screens/transaction/checkout/checkout_screen.dart';
import 'package:lentera_ilmu/screens/widgets/list_item_cart.dart';
import 'package:lentera_ilmu/services/utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreen createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  final orderController = Get.put(OrderController());
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    orderController.getListCart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      // onGenerateInitialRoutes: (_) => tutorialController.fetchTutorial(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Keranjang Saya",
            maxFontSize: 16,
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Get.back(),
            },
          ),
        ),
        body: GetBuilder<OrderController>(
          builder: (order) {
            return order.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  )
                // ignore: prefer_is_empty
                : order.carts.length > 0
                    ? ListView.builder(
                        itemCount: order.carts.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) => ListItemCart(
                          image: order.carts[index].course.thumbnail ?? "",
                          title: order.carts[index].course.title,
                          descriptions:
                              order.carts[index].course.description ?? "",
                          price: formatCurrency.format(
                              double.parse(order.carts[index].course.price)),
                          onDelete: () =>
                              {_delete(context, order.carts[index], order)},
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/empty/cart.png",
                              width: MediaQuery.of(context).size.width * .60,
                            ),
                            const Padding(padding: EdgeInsets.all(14)),
                            const Text("Yaah, keranjang Kamu masih kosong..."),
                            const Padding(padding: EdgeInsets.all(24)),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // ignore: deprecated_member_use
                                  primary: Colors.white,
                                  minimumSize: const Size(50, 16),
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                ),
                                onPressed: () =>
                                    Get.to(() => const BottomNavBar()),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    color: Colors.teal,
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  child: const Text(
                                    "Cari Produk",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
          },
        ),
        bottomNavigationBar: GetBuilder<OrderController>(builder: (order) {
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2.0,
                    offset: Offset(0.0, 0.75))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  formatCurrency.format(order.totalPrice),
                  style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxFontSize: 18,
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.currency_exchange_outlined,
                    size: 20,
                  ),
                  label: const AutoSizeText(
                    "Bayar",
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(14)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        // ignore: prefer_is_empty
                        order.carts.length > 0 ? Colors.teal : Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        side: BorderSide(
                            // ignore: prefer_is_empty
                            color: order.carts.length > 0
                                ? Colors.teal
                                : Colors.grey),
                      ),
                    ),
                  ),
                  // ignore: prefer_is_empty
                  onPressed: () => order.carts.length > 0
                      ? Get.to(() => const CheckoutScreen())
                      : null,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _delete(BuildContext context, CartModel cart, OrderController order) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content:
              const Text('Apakah anda yakin akan menghapus item keranjang ?'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                // Close the dialog
                // Navigator.of(context).pop();
                order.deleteCart(cart, context);
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Batalkan',
                style: TextStyle(color: Colors.teal),
              ),
            )
          ],
        );
      },
    );
  }
}
