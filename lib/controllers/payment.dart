import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/models/payment/destination_bank.dart';
import 'package:lentera_ilmu/models/payment/payment.dart';
import 'package:lentera_ilmu/models/payment/payment_tutorial.dart';
import 'package:lentera_ilmu/models/payment/transaction.dart';
import 'package:lentera_ilmu/models/payment/withdraw_fee.dart';
import 'package:lentera_ilmu/models/payment/withdraw_transaction.dart';
import 'package:lentera_ilmu/models/user/user_bank.dart';
import 'package:lentera_ilmu/screens/withdraw/withdraw_details.dart';
import 'package:lentera_ilmu/services/payment.dart';
import 'package:lentera_ilmu/services/profile.dart';
import 'package:lentera_ilmu/services/utils.dart';

class PaymentController extends GetxController {
  final paymentService = PaymentService();
  final profileService = ProfileService();
  bool loading = false;
  late List<PaymentChannelModel> paymentChannels = <PaymentChannelModel>[].obs;
  late List<TransactionModel> transactions = <TransactionModel>[].obs;
  late List<UserBankModel> userbanks = <UserBankModel>[].obs;
  late List<PaymentTutorialModel> paymentTutorial =
      <PaymentTutorialModel>[].obs;
  late List<DestinationBankModel> destionationBanks =
      <DestinationBankModel>[].obs;
  late List<DestinationBankModel> allDestinationBank =
      <DestinationBankModel>[].obs;
  late DestinationBankModel? selectedDestinationBank;
  late UserBankModel? seletUserBank;
  late List<WithdrawTransactionModel> withdrawHistories =
      <WithdrawTransactionModel>[].obs;
  late WithdrawFeeModel withdrawFee =
      const WithdrawFeeModel(fee: 5000, minimum: 25000);
  WithdrawTransactionModel? withdrawTransaction;
  final accountHolder = TextEditingController();
  final accountNumber = TextEditingController();
  final password = TextEditingController();
  double withdrawAmount = 0;
  String errorMessage = "";
  int lastPage = 0;
  int clickCounter = 0;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  onChangeWithdraw(String value) {
    if (value == "") {
      withdrawAmount = double.parse("0");
    } else {
      withdrawAmount = double.parse(value);
    }
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }

  getListPaymentChannel() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      paymentChannels = await paymentService.getListPaymentChannel();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  getListTransaction({
    required int page,
    required bool restartData,
    String? status,
    bool withLoading = false,
  }) async {
    if (withLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    try {
      final result = await paymentService.getListTransaction(
        size: 20,
        page: page,
        status: status,
      );
      if (restartData) {
        transactions = result;
        loading = false;
      } else {
        transactions.addAll(result);
      }
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  getListDestinationBank() async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      final result = await paymentService.getListDestinationBank();
      allDestinationBank = result;
      destionationBanks = result;
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  searchDestinationBank(String search) async {
    if (search.isEmpty) {
      destionationBanks = allDestinationBank;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    } else {
      destionationBanks = allDestinationBank
          .where(
              (bank) => bank.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
  }

  selectDestinatonBank(DestinationBankModel bank) async {
    selectedDestinationBank = bank;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }

  selectUserBank(UserBankModel bank) async {
    seletUserBank = bank;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }

  addBank(DestinationBankModel? bank) async {
    if (bank == null) {
      errorMessage = "Silahkan pilih bank tujuan.";
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
      return false;
    }
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      // ignore: unused_local_variable
      final result = await paymentService.addBankAccount(
        bankCode: bank.value,
        bankName: bank.name,
        bankIcon: bank.icon,
        accountHolder: accountHolder.text,
        accountNumber: accountNumber.text,
      );
      getListBankAccount(page: 0, resetData: true);
      Get.back();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  getListBankAccount({
    required int page,
    required bool resetData,
    bool useLoading = false,
  }) async {
    if (useLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    try {
      final result = await paymentService.getListBankAccount(
        size: 20,
        page: page,
      );
      if (resetData) {
        userbanks = result;
      } else {
        userbanks.addAll(result);
      }
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  deleteBank(UserBankModel userBank, BuildContext context) async {
    loading = true;
    try {
      // ignore: unused_local_variable
      final result = await paymentService.deleteBankAccount(userBank.id);
      getListBankAccount(page: 0, resetData: true);
      Navigator.of(context).pop();
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  getWithdrawFee() async {
    try {
      final result = await profileService.getSetting('withdraw');
      WithdrawFeeModel parsed = WithdrawFeeModel.fromJson(result);
      withdrawFee = parsed;
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  withdraw(UserBankModel userBank, double amount) async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      final result = await paymentService.withdraw(
          userBank: userBank, amount: amount, password: password.text);
      withdrawTransaction = result;
      Get.to(() =>
          WithdrawTransactionScreen(trxCode: result.trx_code, back: false));
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  withdrawDetails(String trxCode) async {
    loading = true;
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
    try {
      final result = await paymentService.withdrawDetails(trxCode);
      withdrawTransaction = result;
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }

  readPaymentTutorial() async {
    final String response =
        await rootBundle.loadString('assets/json/payment_tutorial.json');
    final data = await json.decode(response);
    paymentTutorial = data
        .map<PaymentTutorialModel>(
            (json) => PaymentTutorialModel.fromJson(json))
        .toList();
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }

  getHistoryWithdraw({
    required int page,
    required bool restartData,
    String? status,
    bool withLoading = false,
  }) async {
    if (withLoading) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 10), () {
        update();
      });
    }
    try {
      final result = await paymentService.getHistoryWithdraw(
        size: 20,
        page: page,
        status: status,
      );
      if (restartData) {
        withdrawHistories = result;
        loading = false;
      } else {
        withdrawHistories.addAll(result);
      }
      loading = false;
      update();
    } catch (e) {
      showErrorMessage(e.toString());
      loading = false;
      update();
    }
  }
}
