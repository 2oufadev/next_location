import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/utils/constants.dart';

class AreasApi {
  Future<DocumentSnapshot?> getAreaByID(String id) async {
    try {
      DocumentSnapshot? documentSnapshot;
      documentSnapshot = await FirebaseFirestore.instance
          .collection('Areas')
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

  Future<DocumentSnapshot?> getAreaBySerial(
      int serial, bool availableOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Areas')
            .where('serial', isEqualTo: serial)
            .where('available', isEqualTo: true)
            .get()
            .timeout(Constants.requestsTimeout, onTimeout: () {
          throw 'Timeout';
        });
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Areas')
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

  Future<QuerySnapshot?> getCitysAreas(
      String cityId, bool availableOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Areas')
            .where('cityId', isEqualTo: cityId)
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
            .collection('Areas')
            .where('cityId', isEqualTo: cityId)
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

  Future<QuerySnapshot?> getAllAreas(bool availableOnly) async {
    QuerySnapshot? querySnapshot;
    try {
      if (availableOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Areas')
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
            await FirebaseFirestore.instance.collection('Areas').get().timeout(
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
}
