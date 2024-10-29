import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/model/transactions_model.dart';
import 'package:ntp/ntp.dart';

class TransactionsApi {
  Future<dynamic> addTransaction(TransactionsModel model) async {
    try {
      Random random = Random();
      bool idAvailable = false;
      int serial = 0;
      while (!idAvailable) {
        int randomNumber = random.nextInt(1000000000);
        serial = 1000000000 + randomNumber;
        idAvailable = await checkTransactionSerialAvailability(serial);
      }
      model.serial = serial;
      DocumentReference ref = await FirebaseFirestore.instance
          .collection('Transactions')
          .add(model.toJson());
      model.transactionId = ref.id;
      ref.update({'transactionId': ref.id});
      return model;
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  Future<dynamic> editTransaction(TransactionsModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Transactions')
          .doc(model.userId)
          .set(model.toJson(), SetOptions(merge: true));

      return model;
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  // status options [null = all status, 0 = pending, 1 = successful, 2 = unsuccessful, 3 = rejected, 4 = canceled]
  Future<QuerySnapshot?> getUsersTransactions(String userId,
      TransactionsModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModel != null) {
        if (lastModel.transactionId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .doc(lastModel.transactionId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        }
      }

      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot?> getUsersPrevTransactions(String userId,
      TransactionsModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      DateTime now = await NTP.now();

      if (lastModel != null) {
        if (lastModel.transactionId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .doc(lastModel.transactionId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('createdDate', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('createdDate', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('createdDate', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('createdDate', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        }
      }

      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot?> getUsersUpcomingTransactions(String userId,
      TransactionsModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      DateTime now = await NTP.now();

      if (lastModel != null) {
        if (lastModel.transactionId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .doc(lastModel.transactionId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('createdDate',
                  isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('createdDate',
                  isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('createdDate',
                  isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Transactions')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('createdDate',
                  isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        }
      }

      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<int> getUsersTransactionsCount(String userId, int? status) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Transactions')
            .where('userId', isEqualTo: userId)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Transactions')
            .where('userId', isEqualTo: userId)
            .where('status', isEqualTo: status)
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> getUsersPrevTransactionsCount(String userId, int? status) async {
    try {
      DateTime now = await NTP.now();

      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Transactions')
            .where('userId', isEqualTo: userId)
            .where('createdDate', isLessThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Transactions')
            .where('userId', isEqualTo: userId)
            .where('status', isEqualTo: status)
            .where('createdDate', isLessThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> getUsersUpcomingTransactionsCount(
      String userId, int? status) async {
    try {
      DateTime now = await NTP.now();

      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Transactions')
            .where('userId', isEqualTo: userId)
            .where('createdDate',
                isGreaterThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Transactions')
            .where('userId', isEqualTo: userId)
            .where('status', isEqualTo: status)
            .where('createdDate',
                isGreaterThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<bool> checkTransactionSerialAvailability(int serial) async {
    QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
        .collection('Transactions')
        .where('serial', isEqualTo: serial)
        .get();
    return querySnapshot.docs.isEmpty;
  }
}
