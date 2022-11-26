import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeskripsiShowroom extends StatefulWidget {
  const DeskripsiShowroom({Key? key}) : super(key: key);

  @override
  State<DeskripsiShowroom> createState() => _DeskripsiShowroomState();
}

class _DeskripsiShowroomState extends State<DeskripsiShowroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const AutoSizeText(
          "Detail Produk",
          maxFontSize: 16,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => {
            Get.back(),
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/img/Risoles.png",
                          width: 80,
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        const Text.rich(
                          TextSpan(
                            text: 'Rp. 10.000.000',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.teal,
                            ),
                            children: [
                              TextSpan(
                                text: '\nPT Indonesian Kuliner',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: const [
                        AutoSizeText(
                          "Deskripsi",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: const [
                        AutoSizeText.rich(
                          TextSpan(
                            text:
                                "PT Indonesian Kuliner merupakan bisnis yang bergerak pada pasar kuliner UMKM Indonesia yang menjual berbagai produk olahan makanan ringan lainnya, seperti cake, risoles, kebab dll nya. Pembelian showroom ini sudah termasuk stok bahan baku lengkap selama 1 bulan dan pembagian keuntungannya 40% mitra, 55% brand owner, dan 5% penyedia yaitu Lentera Ilmu. Jika bahan baku stok yang dimiliki mitra sudah habis mitra dapat membeli kembali kelengkapan stok bahan baku usahanya.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              color: Color(0x70252424),
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "\n\n*Note : Jika stok pada bahan baku usaha mitra telah habis, maka mitra dapat membeli kembalinya dengan cara pergi kehalaman history cari riwayat transaksi mitra pada pembelian showroom yang mitra beli, lalu tekan tombol yang bergambarkan tas yang ada di halaman showroom frenchise yang mitra beli maka nanti akan mucul halaman market stok bahan baku dari frenchise yang sudah dibeli mitra, setelah itu disesuaikan saja dengan keinginan dan kebutuhan mitra untuk stok bahan baku kelengkapannya mau 1 bulan, 3 bulan, atau 12 bulan.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
