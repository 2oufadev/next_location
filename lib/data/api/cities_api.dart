import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/utils/constants.dart';

class CitiesApi {
  Future<DocumentSnapshot?> getCityByID(String id) async {
    try {
      DocumentSnapshot? documentSnapshot;
      documentSnapshot = await FirebaseFirestore.instance
          .collection('Cities')
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

  Future<DocumentSnapshot?> getCityBySerial(
      int serial, bool availableOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Cities')
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
            .collection('Cities')
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

  Future<QuerySnapshot?> getCountrysCities(
      String countryId, bool availableOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Cities')
            .where('countryId', isEqualTo: countryId)
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
            .collection('Cities')
            .where('countryId', isEqualTo: countryId)
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

  Future<QuerySnapshot?> getAllCities(bool availableOnly) async {
    QuerySnapshot? querySnapshot;
    try {
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Cities')
            .where('available', isEqualTo: true)
            .get()
            .timeout(
          Constants.requestsTimeout,
          onTimeout: () {
            throw 'Timeout';
          },
        );
      } else {
        querySnapshot =
            await FirebaseFirestore.instance.collection('Cities').get().timeout(
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
