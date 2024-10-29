import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/model/visit_model.dart';
import 'package:next_location/utils/constants.dart';
import 'package:ntp/ntp.dart';

class VisitsApi {
  // End Users
  Future<dynamic> bookAVisit(VisitModel model) async {
    try {
      Random random = Random();
      bool serialAvailable = false;
      int serial = 0;
      while (!serialAvailable) {
        int randomNumber = random.nextInt(1000000000);
        serial = 1000000000 + randomNumber;
        serialAvailable = await checkVisitSerialAvailability(serial);
      }
      model.serial = serial;
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('Visits')
          .add(model.toJson());
      documentReference.update({'visitId': documentReference.id});
      model.visitId = documentReference.id;

      return model;
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  // status options [null = all status, 0 = requested, 1 = approved, 2 = rejected, 3 = canceled, 4 = rescheduled]
  Future<QuerySnapshot?> getUsersVisits(String userId, VisitModel? lastModel,
      bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModel != null) {
        if (lastModel.visitId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .doc(lastModel.visitId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('date', isEqualTo: lastModel.date!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .orderBy('date', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .orderBy('date', descending: descending)
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

  Future<QuerySnapshot?> getUsersPrevVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;
    DocumentSnapshot? documentSnapshot;
    DateTime now = await NTP.now();

    try {
      if (lastModel != null) {
        if (lastModel.visitId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .doc(lastModel.visitId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('date', isEqualTo: lastModel.date!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
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

  Future<QuerySnapshot?> getUsersUpcomingVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;
    DocumentSnapshot? documentSnapshot;
    DateTime now = await NTP.now();

    try {
      if (lastModel != null) {
        if (lastModel.visitId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .doc(lastModel.visitId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('date', isEqualTo: lastModel.date!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }

        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
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

  Future<int> getUsersVisitsCount(String userId, int? status) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('userId', isEqualTo: userId)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
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

  Future<int> getUsersPrevVisitsCount(String userId, int? status) async {
    try {
      DateTime now = await NTP.now();
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('userId', isEqualTo: userId)
            .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('userId', isEqualTo: userId)
            .where('status', isEqualTo: status)
            .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> getUsersUpcomingVisitsCount(String userId, int? status) async {
    try {
      DateTime now = await NTP.now();
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('userId', isEqualTo: userId)
            .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('userId', isEqualTo: userId)
            .where('status', isEqualTo: status)
            .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future cancelVisit(VisitModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Visits')
          .doc(model.visitId)
          .update({'status': 3}).timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> checkVisitSerialAvailability(int serial) async {
    QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
        .collection('Visits')
        .where('serial', isEqualTo: serial)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  // Owners & Real Estate Users
  Future<dynamic> approveAVisit(VisitModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Visits')
          .doc(model.visitId)
          .update({'status': 1}).timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> rejectAVisit(VisitModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Visits')
          .doc(model.visitId)
          .update({'status': 2}).timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> rescheduleAVisit(VisitModel model, Timestamp newDate) async {
    try {
      await FirebaseFirestore.instance
          .collection('Visits')
          .doc(model.visitId)
          .update({'date': newDate}).timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  // status options [null = all status, 0 = requested, 1 = approved, 2 = rejected, 3 = canceled, 4 = rescheduled]
  Future<QuerySnapshot?> getOwnersVisits(String userId, VisitModel? lastModel,
      bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModel != null) {
        if (lastModel.visitId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .doc(lastModel.visitId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('date', isEqualTo: lastModel.date!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .orderBy('date', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .orderBy('date', descending: descending)
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

  Future<QuerySnapshot?> getOwnersPrevVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;
    DocumentSnapshot? documentSnapshot;
    DateTime now = await NTP.now();

    try {
      if (lastModel != null) {
        if (lastModel.visitId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .doc(lastModel.visitId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('date', isEqualTo: lastModel.date!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
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

  Future<QuerySnapshot?> getOwnersUpcomingVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;
    DocumentSnapshot? documentSnapshot;
    DateTime now = await NTP.now();

    try {
      if (lastModel != null) {
        if (lastModel.visitId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .doc(lastModel.visitId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('date', isEqualTo: lastModel.date!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }

        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Visits')
              .where('ownerId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
              .orderBy('date', descending: descending)
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

  Future<int> getOwnersVisitsCount(String userId, int? status) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('ownerId', isEqualTo: userId)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('ownerId', isEqualTo: userId)
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

  Future<int> getOwnersPrevVisitsCount(String userId, int? status) async {
    try {
      DateTime now = await NTP.now();
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('ownerId', isEqualTo: userId)
            .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('ownerId', isEqualTo: userId)
            .where('status', isEqualTo: status)
            .where('date', isLessThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<int> getOwnersUpcomingVisitsCount(String userId, int? status) async {
    try {
      DateTime now = await NTP.now();
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('ownerId', isEqualTo: userId)
            .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Visits')
            .where('ownerId', isEqualTo: userId)
            .where('status', isEqualTo: status)
            .where('date', isGreaterThan: Timestamp.fromDate(now.toUtc()))
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }
}
