import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/transactions_api.dart';
import 'package:next_location/data/model/transactions_model.dart';

class TransactionsRepository {
  Future<dynamic> addTransaction(TransactionsModel model) async {
    return await TransactionsApi().addTransaction(model);
  }

  Future<dynamic> editTransaction(TransactionsModel model) async {
    return await TransactionsApi().editTransaction(model);
  }

  // status options [null = all status, 0 = pending, 1 = successful, 2 = unsuccessful, 3 = rejected, 4 = canceled]
  Future<List<TransactionsModel>> getUsersTransactions(String userId,
      TransactionsModel? lastModel, bool descending, int? status) async {
    List<TransactionsModel> visitsList = [];
    QuerySnapshot? querySnapshot = await TransactionsApi()
        .getUsersTransactions(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => TransactionsModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<List<TransactionsModel>> getUsersPrevTransactions(String userId,
      TransactionsModel? lastModel, bool descending, int? status) async {
    List<TransactionsModel> visitsList = [];
    QuerySnapshot? querySnapshot = await TransactionsApi()
        .getUsersPrevTransactions(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => TransactionsModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<List<TransactionsModel>> getUsersUpcomingTransactions(String userId,
      TransactionsModel? lastModel, bool descending, int? status) async {
    List<TransactionsModel> visitsList = [];
    QuerySnapshot? querySnapshot = await TransactionsApi()
        .getUsersUpcomingTransactions(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => TransactionsModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<int> getUsersTransactionsCount(String userId, int? status) async {
    return await TransactionsApi().getUsersTransactionsCount(userId, status);
  }

  Future<int> getUsersPrevTransactionsCount(String userId, int? status) async {
    return await TransactionsApi()
        .getUsersPrevTransactionsCount(userId, status);
  }

  Future<int> getUsersUpcomingTransactionsCount(
      String userId, int? status) async {
    return await TransactionsApi()
        .getUsersUpcomingTransactionsCount(userId, status);
  }
}
