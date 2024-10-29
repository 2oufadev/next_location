import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/model/invoice_model.dart';
import 'package:next_location/utils/constants.dart';

class InvoicesApi {
  Future<dynamic> addInvoice(InvoiceModel model) async {
    try {
      Random random = Random();
      bool serialAvailable = false;
      int serial = 0;
      while (!serialAvailable) {
        int randomNumber = random.nextInt(1000000000);
        serial = 1000000000 + randomNumber;
        serialAvailable = await checkInvoiceSerialAvailability(serial);
      }
      model.serial = serial;
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('Invoices')
          .add(model.toJson())
          .timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      documentReference.update({'invoiceId': documentReference.id});
      model.invoiceId = documentReference.id;

      return model;
    } catch (e) {
      return e;
    }
  }

  Future<bool> updateInvoice(InvoiceModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Invoices')
          .doc(model.invoiceId)
          .set(model.toJson(), SetOptions(merge: true))
          .timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<QuerySnapshot?> getUsersInvoices(
      String userId, bool approvedOnly) async {
    try {
      QuerySnapshot querySnapshot;

      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Invoices')
            .where('userId', isEqualTo: userId)
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
            .collection('Invoices')
            .where('userId', isEqualTo: userId)
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

  Future<DocumentSnapshot?> getInvoiceByID(String id) async {
    try {
      DocumentSnapshot? documentSnapshot = await FirebaseFirestore.instance
          .collection('Invoices')
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

  Future<DocumentSnapshot?> getInvoiceBySerial(
      int serial, bool approvedOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Invoices')
            .where('serial', isEqualTo: serial)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(Constants.requestsTimeout, onTimeout: () {
          throw 'Timeout';
        });
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Invoices')
            .where('serial', isEqualTo: serial)
            .get()
            .timeout(Constants.requestsTimeout, onTimeout: () {
          throw 'Timeout';
        });
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

  Future<dynamic> getUsersInvoicesCount(
      String userId, bool approvedOnly) async {
    try {
      AggregateQuerySnapshot snapshot;

      if (approvedOnly) {
        snapshot = await FirebaseFirestore.instance
            .collection('Invoices')
            .where('userId', isEqualTo: userId)
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
            .collection('Invoices')
            .where('userId', isEqualTo: userId)
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

  Future<bool> checkInvoiceSerialAvailability(int serial) async {
    try {
      QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
          .collection('Invoices')
          .where('serial', isEqualTo: serial)
          .get();
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      return false;
    }
  }
}
