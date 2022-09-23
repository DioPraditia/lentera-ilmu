import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final formatCurrency =
    NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

String parseDate(String datetime) {
  return datetime.substring(0, 10) + ' ' + datetime.substring(11, 19);
}

String parseSubscriptionItemType(String status) {
  if (status == "course") {
    return "Kursus";
  }
  if (status == "activity") {
    return "Kegiatan";
  }
  return "";
}

String parsePaymentStatus(String status) {
  if (status == "waiting") {
    return "Menunggu Pembayaran";
  }
  if (status == "payment" || status == "approved") {
    return "Sudah Dibayar";
  }
  if (status == "canceled" || status == "rejected") {
    return "Dibatalkan";
  }
  return "";
}

String parseWithdrawStatus(String status) {
  if (status == "process") {
    return "Dalam Proses";
  }
  if (status == "success") {
    return "Sukses";
  }
  if (status == "reversal") {
    return "Dibatalkan";
  }
  return "";
}

Color parsePaymentStatusColor(String status) {
  if (status == "waiting" || status == "process") {
    return Colors.orange;
  }
  if (status == "payment" || status == "approved" || status == "success") {
    return Colors.green;
  }
  if (status == "canceled" || status == "rejected" || status == "reversal") {
    return Colors.red;
  }
  return Colors.grey;
}

Future<dynamic> showErrorMessage(String message) async {
  Get.defaultDialog(
    title: "Terjadi Kendala",
    middleText: message,
    middleTextStyle: const TextStyle(color: Colors.redAccent),
    textCancel: "Tutup",
    cancelTextColor: Colors.teal,
    buttonColor: Colors.transparent,
    barrierDismissible: false,
    radius: 8,
  );
}

Future<dynamic> bottomSheet({
  required BuildContext context,
  required String title,
  required String message,
  required Function confirmAction,
}) async {
  showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (builder) {
      return Container(
        height: MediaQuery.of(context).size.width * .7,
        color: Colors.transparent, //could change this to Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Text(message),
                const Padding(padding: EdgeInsets.all(18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text(
                        "Kembali",
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(14)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            side: BorderSide(color: Colors.teal),
                          ),
                        ),
                      ),
                      onPressed: () => confirmAction,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
