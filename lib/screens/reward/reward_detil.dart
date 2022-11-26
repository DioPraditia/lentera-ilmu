import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:lentera_ilmu/controllers/lms.dart';
import 'package:lentera_ilmu/screens/reward/syarat&ketentuan.dart';
import 'package:lentera_ilmu/screens/subscription/subscription_screen.dart';
// ignore: unused_import
import 'package:lentera_ilmu/theme.dart';
// ignore: unused_import
import 'package:video_player/video_player.dart';

class RewardDetil extends StatefulWidget {
  const RewardDetil({Key? key}) : super(key: key);

  @override
  State<RewardDetil> createState() => _RewardDetilState();
}

class _RewardDetilState extends State<RewardDetil> {
  final lmsController = Get.put(LMSController());
  VideoPlayerController? _controller;
  Future<void>? futureController;

  Future refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    lmsController.getHomeData();
  }

  @override
  void initState() {
    lmsController.onInit();
    lmsController.getHomeData();

    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    futureController = _controller?.initialize();
    _controller?.setLooping(true);
    _controller?.setVolume(10.0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LMSController>(
      builder: (lms) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const Text("Reward Detil"),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => {
                  Get.back(),
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/img/cover.png',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Keuntungan Reward buatmu',
                              style: rewardtitleTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/Jam.png',
                              width: 36,
                              height: 39.8,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Tanpa batas waktu',
                                style: tanpabataswaktuTextStyle,
                                children: [
                                  TextSpan(
                                    text:
                                        '\nRewardmu dapat di klaim kapanpun, \ntanpa terikat batasan waktu.',
                                    style: tanpabataswaktu2TextStyle,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/IconR.png',
                              width: 36,
                              height: 39.8,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Kouta reward tanpa batas',
                                style: tanpabataswaktuTextStyle,
                                children: [
                                  TextSpan(
                                    text:
                                        '\nSiapapun bisa mendapatkan reward dan, \nbebas melakukan withdraw jika persyaratan, \nsudah terpenuhi.',
                                    style: tanpabataswaktu2TextStyle,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/img/coin.png',
                              width: 36,
                              height: 39.8,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Bebas withdraw reward',
                                style: tanpabataswaktuTextStyle,
                                children: [
                                  TextSpan(
                                    text:
                                        '\nRewardmu baru bisa di withdraw jika kamu, \nmedirect pengguna dan pengguna tersebut \nberhasil melakukan transaksi bundling.',
                                    style: tanpabataswaktu2TextStyle,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: FutureBuilder(
                            future: futureController,
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                );
                              } else {
                                return const Center();
                              }
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(87.0),
                          child: Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller!.value.isPlaying
                                      ? _controller?.pause()
                                      : _controller?.play();
                                });
                              },
                              child: Icon(
                                _controller!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "*Keuntungan yang diterima sesuai",
                          style: KeuntunganTextStyle,
                        ),
                        InkWell(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SyaratKetentuan(),
                              ),
                            );
                          }),
                          child: Text(
                            " Syarat & Ketentuan Reward",
                            style: syaratTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ListView.builder(
                      itemCount: lms.subscriptions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item = {};
                        return Container(
                          width: 327,
                          height: 60,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(53),
                                )),
                            onPressed: () => {
                              Get.to(
                                () => SubscriptionScreen(
                                  subscriptionId: lms.subscriptions[index].id,
                                ),
                              ),
                            },
                            child: Text(
                              'Dapatkan Reward',
                              style: buttonTextStyle,
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
