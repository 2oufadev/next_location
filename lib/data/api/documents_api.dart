import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/api/storage_api.dart';
import 'package:next_location/data/model/documents_model.dart';
import 'package:next_location/utils/constants.dart';

class DocumentsApi {
  Future<bool> checkDocumentsSerialAvailability(int serial) async {
    QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
        .collection('Documents')
        .where('serial', isEqualTo: serial)
        .get()
        .timeout(
      Constants.requestsTimeout,
      onTimeout: () {
        throw 'Timeout';
      },
    );
    return querySnapshot.docs.isEmpty;
  }

  Future<dynamic> addDocument(DocumentsModel model) async {
    try {
      if (model.file != null) {
        String url = await StorageApi().addToStorage(
            model.file!,
            model.documentType == 0
                ? 'PropertiesDocuments'
                : model.documentType == 1
                    ? 'ContractsDocuments'
                    : model.documentType == 2
                        ? 'UsersVerificationsDocuments'
                        : 'Documents');
        model.url = url;
      }
      Random random = Random();

      int serial = 0;
      bool serialAvailable = false;
      while (!serialAvailable) {
        int randomNumber = random.nextInt(1000000000);
        serial = 1000000000 + randomNumber;
        bool result = await checkDocumentsSerialAvailability(serial);
        if (result) {
          serialAvailable = true;
        }
      }
      model.serial = serial;
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('Documents')
          .add(model.toJson())
          .timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      documentReference.update({'documentId': documentReference.id});
      model.documentId = documentReference.id;

      return model;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> updateDocument(DocumentsModel model) async {
    try {
      if (model.file != null) {
        String url = await StorageApi().addToStorage(
            model.file!,
            model.documentType == 0
                ? 'PropertiesDocuments'
                : model.documentType == 1
                    ? 'ContractsDocuments'
                    : model.documentType == 2
                        ? 'UsersVerificationsDocuments'
                        : 'Documents');
        model.url = url;
      }
      await FirebaseFirestore.instance
          .collection('Documents')
          .doc(model.documentId)
          .set(model.toJson(), SetOptions(merge: true))
          .timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );

      return model;
    } catch (e) {
      return e.toString();
    }
  }

  Future<DocumentSnapshot?> getDocumentByID(String id) async {
    try {
      DocumentSnapshot? documentSnapshot = await FirebaseFirestore.instance
          .collection('Documents')
          .doc(id)
          .get()
          .timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );

      return documentSnapshot;
    } catch (e) {
      return null;
    }
  }

  Future<DocumentSnapshot?> getDocumentBySerial(
      int serial, bool approvedOnly) async {
    try {
      QuerySnapshot? querySnapshot;
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('serial', isEqualTo: serial)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('serial', isEqualTo: serial)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      }

      DocumentSnapshot? documentSnapshot;
      if (querySnapshot.docs.isNotEmpty) {
        documentSnapshot = querySnapshot.docs.first;
      }
      return documentSnapshot;
    } catch (e) {
      return null;
    }
  }

  Future<QuerySnapshot?> getUsersDocuments(
      String userId, bool approvedOnly) async {
    try {
      QuerySnapshot? querySnapshot;
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('submitterId', isEqualTo: userId)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('submitterId', isEqualTo: userId)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      }

      return querySnapshot;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getUsersDocumentsCount(
      String userId, bool approvedOnly) async {
    try {
      AggregateQuerySnapshot snapshot;
      if (approvedOnly) {
        snapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('submitterId', isEqualTo: userId)
            .where('status', isEqualTo: 1)
            .count()
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('submitterId', isEqualTo: userId)
            .count()
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      }

      return snapshot.count ?? 0;
    } catch (e) {
      return e.toString();
    }
  }

  Future<QuerySnapshot?> getPropertysDocuments(
      String propertyId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    try {
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('documentType', isEqualTo: 0)
            .where('reference', isEqualTo: propertyId)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('documentType', isEqualTo: 0)
            .where('reference', isEqualTo: propertyId)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return querySnapshot;
  }

  Future<QuerySnapshot?> getContractsDocuments(
      String contractId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    try {
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('documentType', isEqualTo: 1)
            .where('reference', isEqualTo: contractId)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('documentType', isEqualTo: 1)
            .where('reference', isEqualTo: contractId)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return querySnapshot;
  }

  Future<QuerySnapshot?> getUsersVerificationsDocuments(
      String verificationId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    try {
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('documentType', isEqualTo: 2)
            .where('reference', isEqualTo: verificationId)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Documents')
            .where('documentType', isEqualTo: 2)
            .where('reference', isEqualTo: verificationId)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return querySnapshot;
  }
}
