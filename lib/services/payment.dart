import 'package:lentera_ilmu/models/lms/course.dart';
import 'package:lentera_ilmu/models/lms/subscription_price.dart';
import 'package:lentera_ilmu/models/payment/destination_bank.dart';
import 'package:lentera_ilmu/models/payment/payment.dart';
import 'package:lentera_ilmu/models/payment/transaction.dart';
import 'package:lentera_ilmu/models/payment/withdraw_transaction.dart';
import 'package:lentera_ilmu/models/user/user_bank.dart';
import 'package:lentera_ilmu/services/service.dart';

class PaymentService extends ServiceAPI {
  Future<List<PaymentChannelModel>> getListPaymentChannel() async {
    try {
      final result = await get("$baseUrlPayment/bank/channel");
      return result
          .map<PaymentChannelModel>(
              (json) => PaymentChannelModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<TransactionModel>> getListTransaction({
    required int size,
    required int page,
    String? status,
  }) async {
    try {
      final result = await get(
        "$baseUrlLMS/transaction/list",
        queryParameters: {
          "pagination": true,
          "page": page,
          "size": size,
        },
      );
      return result['items']
          .map<TransactionModel>((json) => TransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<TransactionModel> requestPaymentCourse({
    required PaymentChannelModel payment,
    required List<CourseModel> items,
  }) async {
    try {
      final result = await post(
        "$baseUrlLMS/transaction/course",
        data: {
          'payment': payment,
          'items': items,
        },
      );
      return TransactionModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<TransactionModel> getTransaction(String trxCode) async {
    try {
      final result = await get(
        "$baseUrlLMS/transaction",
        queryParameters: {'trx_code': trxCode},
      );
      return TransactionModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<TransactionModel> requestPaymentSubsctiption({
    required int subscriptionID,
    required SubscriptionPriceModel price,
    required PaymentChannelModel payment,
  }) async {
    try {
      final result = await post(
        "$baseUrlLMS/transaction/subscription",
        data: {
          'payment': payment,
          'subscription_id': subscriptionID,
          'price': price,
        },
      );
      return TransactionModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DestinationBankModel>> getListDestinationBank() async {
    try {
      final result = await get("$baseUrlPayment/bank/destination");
      return result
          .map<DestinationBankModel>(
              (json) => DestinationBankModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> addBankAccount({
    required String bankCode,
    required String bankName,
    required String bankIcon,
    required String accountHolder,
    required String accountNumber,
  }) async {
    try {
      await post(
        "$baseUrlUser/user/bank",
        data: {
          'bank_code': bankCode,
          'bank_name': bankName,
          'bank_icon': bankIcon,
          'account_holder': accountHolder,
          'account_number': accountNumber,
        },
      );
      return "Sukses";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UserBankModel>> getListBankAccount({
    required int size,
    required int page,
  }) async {
    try {
      final result = await get(
        "$baseUrlUser/user/bank/list",
        queryParameters: {
          "pagination": true,
          "page": page,
          "size": size,
        },
      );
      return result["items"]
          .map<UserBankModel>((json) => UserBankModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> deleteBankAccount(int id) async {
    try {
      await delete(
        "$baseUrlUser/user/bank",
        queryParameters: {"id": id},
      );
      return "Berhasil";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WithdrawTransactionModel> withdraw({
    required UserBankModel userBank,
    required double amount,
    required String password,
  }) async {
    try {
      final result = await post(
        "$baseUrlPayment/disbursement",
        data: {
          "amount": amount,
          "destination_bank_name": userBank.bank_name,
          "destination_bank_code": userBank.bank_code,
          "destination_bank_id": userBank.id,
          "password": password,
        },
      );
      return WithdrawTransactionModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WithdrawTransactionModel> withdrawDetails(String trxCode) async {
    try {
      final result = await get(
        "$baseUrlPayment/disbursement",
        queryParameters: {"trx_code": trxCode},
      );
      return WithdrawTransactionModel.fromJson(result);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<WithdrawTransactionModel>> getHistoryWithdraw({
    required int size,
    required int page,
    String? status,
  }) async {
    try {
      final result = await get(
        "$baseUrlPayment/disbursement/list",
        queryParameters: {
          "pagination": true,
          "page": page,
          "size": size,
        },
      );
      return result['items']
          .map<WithdrawTransactionModel>(
              (json) => WithdrawTransactionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
