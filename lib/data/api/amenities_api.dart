import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AmenitiesApi {
  Future<QuerySnapshot?> getAllAmenities(bool availableOnly) async {
    try {
      QuerySnapshot? querySnapshot;

      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Amenities')
            .where('available', isEqualTo: true)
            .get();
      } else {
        querySnapshot =
            await FirebaseFirestore.instance.collection('Amenities').get();
      }
      return querySnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<DocumentSnapshot?> getAmenityByID(String id) async {
    try {
      DocumentSnapshot? documentSnapshot;
      documentSnapshot = await FirebaseFirestore.instance
          .collection('Amenities')
          .doc(id)
          .get();

      return documentSnapshot;
    } catch (e) {
      return null;
    }
  }

  Future<QuerySnapshot?> getPropertyTypesAmenities(
      String propertyTypeId, bool availableOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Amenities')
            .where('available', isEqualTo: true)
            .where('propertyTypes', arrayContains: propertyTypeId)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Amenities')
            .where('propertyTypes', arrayContains: propertyTypeId)
            .get();
      }

      return querySnapshot;
    } catch (e) {
      return null;
    }
  }
}
