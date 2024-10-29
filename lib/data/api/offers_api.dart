import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/model/offers_model.dart';

class OffersApi {
  Future<DocumentSnapshot?> getOfferById(String id) async {
    try {
      DocumentSnapshot? documentSnapshot =
          await FirebaseFirestore.instance.collection('Offers').doc(id).get();

      return documentSnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<dynamic> addOffer(OffersModel model) async {
    try {
      Random random = Random();
      bool idAvailable = false;
      int serial = 0;
      while (!idAvailable) {
        int randomNumber = random.nextInt(1000000000);
        serial = 1000000000 + randomNumber;
        idAvailable = await checkOfferSerialAvailability(serial);
      }
      model.serial = serial;
      DocumentReference reference = await FirebaseFirestore.instance
          .collection('Offers')
          .add(model.toJson());
      reference.update({'offerId': reference.id});
      model.offerId = reference.id;
      return model;
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  Future<dynamic> editOffer(OffersModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Offers')
          .doc(model.offerId)
          .set(model.toJson(), SetOptions(merge: true));

      return model;
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  // status options [null = all status, 0 = pending, 1 = accepted, 2 = rejected, 3 = canceled]
  Future<QuerySnapshot?> getUsersOffers(String userId, OffersModel? lastModel,
      bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModel != null) {
        if (lastModel.offerId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .doc(lastModel.offerId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('userId', isEqualTo: userId)
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
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
              .collection('Offers')
              .where('userId', isEqualTo: userId)
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
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

  Future<int> getUsersOffersCount(String userId, int? status) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Offers')
            .where('userId', isEqualTo: userId)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Offers')
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

  Future<bool> checkOfferSerialAvailability(int serial) async {
    QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
        .collection('Offers')
        .where('serial', isEqualTo: serial)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  // status options [null = all status, 0 = pending, 1 = accepted, 2 = rejected, 3 = canceled]
  Future<QuerySnapshot?> getOwnersOffers(String userId, OffersModel? lastModel,
      bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModel != null) {
        if (lastModel.offerId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .doc(lastModel.offerId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('ownerId', isEqualTo: userId)
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('ownerId', isEqualTo: userId)
              .where('status', isEqualTo: status)
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('ownerId', isEqualTo: userId)
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('ownerId', isEqualTo: userId)
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

  Future<int> getOwnersOffersCount(String userId, int? status) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Offers')
            .where('ownerId', isEqualTo: userId)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Offers')
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

  // status options [null = all status, 0 = pending, 1 = accepted, 2 = rejected, 3 = canceled]
  Future<QuerySnapshot?> getPropertysOffers(String propertyId,
      OffersModel? lastModel, bool descending, int? status) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModel != null) {
        if (lastModel.offerId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .doc(lastModel.offerId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('propertyId', isEqualTo: propertyId)
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('propertyId', isEqualTo: propertyId)
              .where('status', isEqualTo: status)
              .orderBy('createdDate', descending: descending)
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (status == null) {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('propertyId', isEqualTo: propertyId)
              .orderBy('createdDate', descending: descending)
              .limit(10)
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Offers')
              .where('propertyId', isEqualTo: propertyId)
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

  Future<int> getPropertysOffersCount(String propertyId, int? status) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (status == null) {
        snapshot = await FirebaseFirestore.instance
            .collection('Offers')
            .where('propertyId', isEqualTo: propertyId)
            .count()
            .get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Offers')
            .where('propertyId', isEqualTo: propertyId)
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
}
