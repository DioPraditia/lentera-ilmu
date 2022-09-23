import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lentera_ilmu/controllers/profile.dart';

class MutationScreen extends StatefulWidget {
  final String mutationType;
  final String mutationTitle;
  const MutationScreen(
      {Key? key, required this.mutationType, required this.mutationTitle})
      : super(key: key);

  @override
  _MutationScreen createState() => _MutationScreen();
}

class _MutationScreen extends State<MutationScreen> {
  late ScrollController scrollController;
  final profileController = Get.put(ProfileController());
  final formatCurrency = NumberFormat.decimalPattern();
  String getInitials(String bankAccountName) => bankAccountName
      .trim()
      .split(RegExp(' +'))
      .map((s) => s[0])
      .take(2)
      .join();
  @override
  void initState() {
    super.initState();
    profileController.getListMutations(
      page: 0,
      restartData: true,
      type: widget.mutationType,
      useLoading: true,
    );
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      profileController.getListMutations(
        page: profileController.lastPage + 1,
        restartData: false,
        type: widget.mutationType,
      );
    }
    if (scrollController.offset <= 0) {
      profileController.getListMutations(
        page: 0,
        restartData: true,
        type: widget.mutationType,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  String parseDate(String datetime) {
    return datetime.substring(0, 10) + ' ' + datetime.substring(11, 19);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Mutasi Points ${widget.mutationTitle}"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Get.back(),
            },
          ),
        ),
        body: GetBuilder<ProfileController>(
          builder: (profil) => profil.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              // ignore: prefer_is_empty
              : profil.mutations.length < 1
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            widget.mutationType != "hold"
                                ? "assets/img/empty/mutation.png"
                                : "assets/img/empty/mutation_happy.png",
                            width: MediaQuery.of(context).size.width * .60,
                          ),
                          const Padding(padding: EdgeInsets.all(14)),
                          Text(widget.mutationType != "hold"
                              ? "Akun ${widget.mutationTitle} Belum Memiliki Mutasi"
                              : "Hore tidak ada point penghasilan yang ditahan."),
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
                              onPressed: () => Get.back(),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  color: Colors.teal,
                                ),
                                padding: const EdgeInsets.all(0),
                                child: const Text(
                                  "Kembali",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: profil.mutations.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          // ignore: avoid_returning_null_for_void
                          onTap: () => null,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(
                                top: 4, bottom: 4, left: 8, right: 8),
                            decoration: BoxDecoration(
                              color:
                                  double.parse(profil.mutations[i].credit) > 0
                                      ? Colors.white
                                      : Colors.red.shade50,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2.0,
                                    offset: Offset(0.0, 0.50))
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parseDate(profil.mutations[i].created_on),
                                      style: const TextStyle(
                                        color: Colors.teal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(1)),
                                    Text(
                                      profil.mutations[i].trx_code,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(1)),
                                    Container(
                                      padding: const EdgeInsets.only(right: 12),
                                      width: MediaQuery.of(context).size.width *
                                          .60,
                                      child: Text(
                                        profil.mutations[i].remarks ?? "-",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${double.parse(profil.mutations[i].credit) > 0 ? "+" : "-"}${formatCurrency.format(double.parse(profil.mutations[i].credit) > 0 ? double.parse(profil.mutations[i].credit) : double.parse(profil.mutations[i].debit))} Points",
                                      style: TextStyle(
                                        color: double.parse(profil
                                                    .mutations[i].credit) >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
