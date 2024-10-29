import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/model/contract_user_model.dart';

class ContractsApi {
  Future<DocumentSnapshot?> getContractById(String id) async {
    try {
      DocumentSnapshot? documentSnapshot = await FirebaseFirestore.instance
          .collection('Contracts')
          .doc(id)
          .get();

      return documentSnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<DocumentSnapshot?> getContractBySerial(
      int serial, bool approvedOnly) async {
    try {
      QuerySnapshot? querySnapshot;
      DocumentSnapshot? documentSnapshot;

      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('serial', isEqualTo: serial)
            .where('status', isEqualTo: 1)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('serial', isEqualTo: serial)
            .get();
      }

      if (querySnapshot.docs.isNotEmpty) {
        documentSnapshot = querySnapshot.docs.first;
      }

      return documentSnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<int> getTenantsContractsCount(String userId, bool approvedOnly) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (approvedOnly) {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('tenant.userId', isEqualTo: userId)
            .where('status', isEqualTo: 1)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('tenant.userId', isEqualTo: userId)
            .count()
            .get();
      }
      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> getLessorsContractsCount(String userId, bool approvedOnly) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (approvedOnly) {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('lessor.userId', isEqualTo: userId)
            .where('status', isEqualTo: 1)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('lessor.userId', isEqualTo: userId)
            .count()
            .get();
      }
      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<QuerySnapshot?> getTenantsContracts(
      String userId, bool approvedOnly) async {
    try {
      QuerySnapshot? snapshot;
      if (approvedOnly) {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('tenant.userId', isEqualTo: userId)
            .where('status', isEqualTo: 1)
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('tenant.userId', isEqualTo: userId)
            .get();
      }
      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot?> getLessorsContracts(
      String userId, bool approvedOnly) async {
    try {
      QuerySnapshot? snapshot;
      if (approvedOnly) {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('lessor.userId', isEqualTo: userId)
            .where('status', isEqualTo: 1)
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Contracts')
            .where('lessor.userId', isEqualTo: userId)
            .get();
      }
      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<dynamic> acceptContract(
      String contractId, ContractUserModel userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('Contracts')
          .doc(contractId)
          .set({
        'signators': FieldValue.arrayUnion([userData.toJson()])
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }
}
