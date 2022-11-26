import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:lentera_ilmu/theme.dart';

class ProdukShowroom extends StatefulWidget {
  const ProdukShowroom({Key? key}) : super(key: key);

  @override
  State<ProdukShowroom> createState() => _ProdukShowroomState();
}

class _ProdukShowroomState extends State<ProdukShowroom> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    Widget option(int index, String title, String subTitle, String pricing) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selectedIndex == index
                  ? const Color(0xFF009688)
                  : const Color(0XFF8997B8),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  selectedIndex == index
                      ? Image.asset(
                          "assets/img/button2.png",
                          width: 19,
                          height: 19,
                        )
                      : Image.asset(
                          "assets/img/Ellipse1.png",
                          width: 19,
                          height: 19,
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: planTextStyle,
                      ),
                      Text(
                        subTitle,
                        style: descTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 91,
                  ),
                  Text(
                    pricing,
                    style: priceTextStyle,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget header() {
      return Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 25,
          right: 24,
        ),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/img/Risoles.png",
                width: 267,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Upgrade to',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Stock',
                  style: nexttitleTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 23,
            ),
            Text(
              'Stok bahan baku product frenchise usaha anda sudah mulai menipis dan mau habis? \nEitss.. tenang tidak usah khawatir karena stok bahan bakunya bisa diupgrade loh!',
              style: subtitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget checkoutButton() {
      return Container(
        width: 327,
        height: 60,
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(71),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Upgrade Sekarang',
                style: buttonTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0XFF04112F),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const AutoSizeText(
            "Products",
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(),
                const SizedBox(
                  height: 37,
                ),
                option(0, 'Monthly', '/ 30 hari', 'Rp. 1.000.000'),
                option(1, 'Quarterly', '/ 90 hari', 'Rp. 2.700.000'),
                option(2, 'Yearly', '/ 365 hari', 'Rp. 9.000.000'),
                const SizedBox(
                  height: 50,
                ),
                selectedIndex == -1 ? SizedBox() : checkoutButton(),
                const SizedBox(
                  height: 37,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
