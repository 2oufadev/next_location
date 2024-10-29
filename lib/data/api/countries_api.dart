import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/utils/constants.dart';

class CountriesApi {
  Future<DocumentSnapshot?> getCountryById(String id) async {
    try {
      DocumentSnapshot? documentSnapshot = await FirebaseFirestore.instance
          .collection('Countries')
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

  Future<DocumentSnapshot?> getCountryBySerial(
      int serial, bool availableOnly) async {
    try {
      QuerySnapshot? querySnapshot;
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Countries')
            .where('serial', isEqualTo: serial)
            .where('available', isEqualTo: true)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Countries')
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

  Future<QuerySnapshot?> getAllCountries(bool availableOnly) async {
    QuerySnapshot? querySnapshot;
    try {
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Countries')
            .where('available', isEqualTo: true)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Countries')
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
