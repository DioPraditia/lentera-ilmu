// ignore: unused_import
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:auto_size_text/auto_size_text.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:lentera_ilmu/theme.dart';

class SyaratKetentuan extends StatefulWidget {
  const SyaratKetentuan({Key? key}) : super(key: key);

  @override
  State<SyaratKetentuan> createState() => _SyaratKetentuanState();
}

class _SyaratKetentuanState extends State<SyaratKetentuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const AutoSizeText(
          "REWARD",
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        AutoSizeText(
                          "Apa Itu REWARD?",
                          style: rewardtitleTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Column(
                      children: [
                        AutoSizeText.rich(
                          TextSpan(
                            text: "REWARD",
                            style: tanpabataswaktuTextStyle,
                            children: [
                              TextSpan(
                                text:
                                    " adalah is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                style: tanpabataswaktu2TextStyle,
                              ),
                              TextSpan(
                                text:
                                    "\n\n\nQ: Apakah semua pengguna bisa dapatkan REWARD?",
                                style: QTextStyle,
                              ),
                              TextSpan(
                                text:
                                    "\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                                style: tanpabataswaktu2TextStyle,
                              ),
                              TextSpan(
                                text:
                                    "\n\n\nQ: Apakah syarat untuk dapatkan REWARD?",
                                style: QTextStyle,
                              ),
                              TextSpan(
                                text:
                                    "\nPengguna bisa mendapatkan REWARD bila memenuhi syarat sebagai berikut:",
                                style: tanpabataswaktu2TextStyle,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Contrary to popular belief, Lorem Ipsum is not simply \nrandom text. It has roots in a piece of classical Latin \nliterature from 45 BC, making it over 2000 years old.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "random text. It has roots in a piece of classical Latin \nliterature from 45 BC, making it over 2000 years old.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "literature from 45 BC, making it over 2000 years old.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "from a Lorem Ipsum passage, and going through the \ncites of the word in classical literature, discovered \nthe undoubtable source. ",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "The generated Lorem Ipsum is therefore always \nfree from repetition, injected humour, or non-\ncharacteristic words etc.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: AutoSizeText.rich(
                            TextSpan(
                              text: "Q: Bagaimana cara withdraw REWARD?",
                              style: QTextStyle,
                              children: [
                                TextSpan(
                                  text:
                                      "\nPengguna dapat melakukan withdraw REWARD dengan cara sebagai berikut:",
                                  style: tanpabataswaktu2TextStyle,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Contrary to popular belief, Lorem Ipsum is not simply \nrandom text. It has roots in a piece of classical Latin \nliterature from 45 BC, making it over 2000 years old.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "random text. It has roots in a piece of classical Latin \nliterature from 45 BC, making it over 2000 years old.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "literature from 45 BC, making it over 2000 years old.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "from a Lorem Ipsum passage, and going through the \ncites of the word in classical literature, discovered \nthe undoubtable source. ",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/check.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "The generated Lorem Ipsum is therefore always \nfree from repetition, injected humour, or non-\ncharacteristic words etc.",
                              style: tanpabataswaktu2TextStyle,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
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
