import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/api/storage_api.dart';
import 'package:next_location/data/model/image_model.dart';
import 'package:next_location/data/model/property_model.dart';
import 'package:next_location/data/model/video_model.dart';
import 'package:next_location/utils/constants.dart';
import 'package:ntp/ntp.dart';

class PropertiesApi {
  Future<QuerySnapshot?> getUsersProperties(
      String userId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    try {
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Properties')
            .where('userId', isEqualTo: userId)
            .where('status', isEqualTo: 1)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Properties')
            .where('userId', isEqualTo: userId)
            .get();
      }
      return querySnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return querySnapshot;
    }
  }

  Future<dynamic> addProperty(PropertyModel model) async {
    try {
      for (ImageModel image in model.images ?? []) {
        if (image.imgFile != null) {
          String imgUrl = await StorageApi()
              .addToStorage(image.imgFile!, 'PropertiesImages');
          image.imgUrl = imgUrl;
        }
      }

      for (VideoModel productVideoModel in model.videos ?? []) {
        if (productVideoModel.vidFile != null) {
          String videoUrl = await StorageApi()
              .addToStorage(productVideoModel.vidFile!, 'PropertiesVideos');
          productVideoModel.videoUrl = videoUrl;

          String thumbnailUrl = await StorageApi().addToStorage(
              productVideoModel.imgFile!, 'PropertiesVideosThumbnails');
          productVideoModel.thumbnailUrl = thumbnailUrl;
        }
      }

      Random random = Random();
      int randomNumber = 0;
      int randomNo = 0;
      bool idAvailable = false;
      while (!idAvailable) {
        randomNumber = random.nextInt(1000000000);
        randomNo = 1000000000 + randomNumber;
        bool result = await checkPropertySerialAvailability(randomNo);
        if (result) {
          idAvailable = true;
        }
      }
      model.serial = randomNo;
      DocumentReference reference = await FirebaseFirestore.instance
          .collection('Properties')
          .add(model.toJson());
      model.propertyId = reference.id;
      reference.update({'propertyId': reference.id});
      return model;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<dynamic> editProperty(PropertyModel model) async {
    try {
      for (ImageModel image in model.images ?? []) {
        if (image.imgFile != null) {
          String imgUrl = await StorageApi()
              .addToStorage(image.imgFile!, 'PropertiesImages');
          image.imgUrl = imgUrl;
        }
      }

      for (VideoModel productVideoModel in model.videos!) {
        if (productVideoModel.vidFile != null) {
          String videoUrl = await StorageApi()
              .addToStorage(productVideoModel.vidFile!, 'PropertiesVideos');
          productVideoModel.videoUrl = videoUrl;

          String thumbnailUrl = await StorageApi().addToStorage(
              productVideoModel.imgFile!, 'PropertiesVideosThumbnails');
          productVideoModel.thumbnailUrl = thumbnailUrl;
        }
      }

      await FirebaseFirestore.instance
          .collection('Properties')
          .doc(model.propertyId)
          .set(model.toJson(), SetOptions(merge: true));

      return model;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<DocumentSnapshot?> getPropertyById(String id) async {
    try {
      DocumentSnapshot? documentSnapshot = await FirebaseFirestore.instance
          .collection('Properties')
          .doc(id)
          .get();

      return documentSnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot?> getProperties(PropertyModel? lastModel, String filter,
      bool descending, String searchText, String searchFilter) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModel != null) {
        if (lastModel.propertyId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Properties')
              .doc(lastModel.propertyId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Properties')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }
        if (searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .where(searchFilter,
                    isGreaterThanOrEqualTo: searchText,
                    isLessThanOrEqualTo: searchText.substring(
                            0,
                            searchText.length > 1
                                ? (searchText.length - 1)
                                : null) +
                        String.fromCharCode(
                            searchText.codeUnitAt(searchText.length - 1) + 1))
                .orderBy(searchFilter, descending: descending)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .where(
                  searchFilter,
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy(searchFilter, descending: descending)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          }
        } else {
          if (filter == 'createdDate') {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .orderBy('createdDate', descending: descending)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .orderBy(filter, descending: descending)
                .orderBy('createdDate', descending: true)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          }
        }
      } else {
        if (searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .where(searchFilter,
                    isGreaterThanOrEqualTo: searchText,
                    isLessThanOrEqualTo: searchText.substring(
                            0,
                            searchText.length > 1
                                ? (searchText.length - 1)
                                : null) +
                        String.fromCharCode(
                            searchText.codeUnitAt(searchText.length - 1) + 1))
                .orderBy(searchFilter, descending: descending)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .where(
                  searchFilter,
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy(searchFilter, descending: descending)
                .limit(10)
                .get();
          }
        } else {
          if (filter == 'createdDate') {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .orderBy('createdDate', descending: descending)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Properties')
                .where('status', isEqualTo: 1)
                .orderBy(filter, descending: descending)
                .orderBy('createdDate', descending: true)
                .limit(10)
                .get();
          }
        }
      }

      return snapshot;
    } catch (e) {
      return null;
    }
  }

  Future<int> getPropertiesCount(String searchText, String searchFilter) async {
    try {
      AggregateQuerySnapshot snapshot;

      if (searchText.isNotEmpty) {
        if (searchText.length > 1) {
          snapshot = await FirebaseFirestore.instance
              .collection('Properties')
              .where('status', isEqualTo: 1)
              .where(searchFilter,
                  isGreaterThanOrEqualTo: searchText,
                  isLessThanOrEqualTo: searchText.substring(
                          0,
                          searchText.length > 1
                              ? (searchText.length - 1)
                              : null) +
                      (String.fromCharCode(
                          searchText.codeUnitAt(searchText.length - 1) + 1)))
              .count()
              .get();
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Properties')
              .where('status', isEqualTo: 1)
              .where(
                searchFilter,
                isGreaterThanOrEqualTo: searchText,
              )
              .count()
              .get();
        }
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Properties')
            .where('status', isEqualTo: 1)
            .count()
            .get();
      }

      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> checkPropertySerialAvailability(int serial) async {
    QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
        .collection('Properties')
        .where('serial', isEqualTo: serial)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  Future<bool> checkDocumentSerialAvailability(int serial) async {
    QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
        .collection('Documents')
        .where('serial', isEqualTo: serial)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  Future<DocumentSnapshot?> getPropertyBySerial(int serial) async {
    DocumentSnapshot? documentSnapshot;
    try {
      QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
          .collection('Properties')
          .where("serial", isEqualTo: serial)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        documentSnapshot = querySnapshot.docs.first;
      }
      return documentSnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot?> getPropertiesTypes() async {
    QuerySnapshot? querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection('PropertiesTypes')
        .where('available', isEqualTo: true)
        .orderBy('order')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot?> getAllResidencePropertiesTypes() async {
    QuerySnapshot? querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection('PropertiesTypes')
        .where('available', isEqualTo: true)
        .where('type', isEqualTo: 0)
        .orderBy('order')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot?> getFamilyResidencePropertiesTypes() async {
    QuerySnapshot? querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection('PropertiesTypes')
        .where('available', isEqualTo: true)
        .where('type', isEqualTo: 1)
        .orderBy('order')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot?> getSingleResidencePropertiesTypes() async {
    QuerySnapshot? querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection('PropertiesTypes')
        .where('available', isEqualTo: true)
        .where('type', isEqualTo: 2)
        .orderBy('order')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot?> getAllCommercialPropertiesTypes() async {
    QuerySnapshot? querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection('PropertiesTypes')
        .where('available', isEqualTo: true)
        .where('type', isEqualTo: 3)
        .orderBy('order')
        .get();
    return querySnapshot;
  }

  Future<bool> requestPropertyDeletion(PropertyModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Properties')
          .doc(model.propertyId)
          .update({'status': 4}).timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> deleteProperty(PropertyModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('Properties')
          .doc(model.propertyId)
          .delete()
          .timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Timeout';
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addPropertyToFavorites(
      PropertyModel propertyModel, String userId) async {
    try {
      DateTime currentDate = await NTP.now();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Favorites')
          .doc(propertyModel.propertyId)
          .set({
        'propertyId': propertyModel.propertyId,
        'title': propertyModel.title,
        'date': Timestamp.fromDate(currentDate)
      });

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> removePropertyFromFavorites(
      String propertyId, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Favorites')
          .doc(propertyId)
          .delete();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<QuerySnapshot?> getFavoriteProperties(
      String userId, String? lastModelId, String? searchText) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModelId != null) {
        documentSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('Favorites')
            .doc(lastModelId)
            .get();

        if (searchText != null && searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('Favorites')
                .where('title',
                    isGreaterThanOrEqualTo: searchText,
                    isLessThanOrEqualTo: searchText.substring(
                            0,
                            searchText.length > 1
                                ? (searchText.length - 1)
                                : null) +
                        String.fromCharCode(
                            searchText.codeUnitAt(searchText.length - 1) + 1))
                .orderBy('date')
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('Favorites')
                .where(
                  'title',
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy('date')
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          }
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('Favorites')
              .orderBy('date')
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (searchText != null && searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('Favorites')
                .where('title',
                    isGreaterThanOrEqualTo: searchText,
                    isLessThanOrEqualTo: searchText.substring(
                            0,
                            searchText.length > 1
                                ? (searchText.length - 1)
                                : null) +
                        String.fromCharCode(
                            searchText.codeUnitAt(searchText.length - 1) + 1))
                .orderBy('date')
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('Favorites')
                .where(
                  'title',
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy('date')
                .limit(10)
                .get();
          }
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('Favorites')
              .orderBy('date')
              .limit(10)
              .get();
        }
      }

      List<String> propertiesIds = [];
      if (snapshot.docs.isNotEmpty) {
        propertiesIds = snapshot.docs
            .map(
              (e) => e.get('propertyId').toString(),
            )
            .toList();
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Properties')
          .where('propertyId', whereIn: [propertiesIds]).get();

      return querySnapshot;
    } catch (e) {
      return null;
    }
  }

  Future<int> getFavoritesCount(String userId) async {
    try {
      AggregateQuerySnapshot snapshot;

      snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Favorites')
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> saveProperty(PropertyModel propertyModel, String userId) async {
    try {
      DateTime currentDate = await NTP.now();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('SavedProperties')
          .doc(propertyModel.propertyId)
          .set({
        'propertyId': propertyModel.propertyId,
        'title': propertyModel.title,
        'date': Timestamp.fromDate(currentDate)
      });

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> removeFromSavedProperties(
      String propertyId, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('SavedProperties')
          .doc(propertyId)
          .delete();

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<QuerySnapshot?> getSavedProperties(
      String userId, String? lastModelId, String? searchText) async {
    QuerySnapshot snapshot;

    DocumentSnapshot? documentSnapshot;

    try {
      if (lastModelId != null) {
        documentSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('SavedProperties')
            .doc(lastModelId)
            .get();

        if (searchText != null && searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('SavedProperties')
                .where('title',
                    isGreaterThanOrEqualTo: searchText,
                    isLessThanOrEqualTo: searchText.substring(
                            0,
                            searchText.length > 1
                                ? (searchText.length - 1)
                                : null) +
                        String.fromCharCode(
                            searchText.codeUnitAt(searchText.length - 1) + 1))
                .orderBy('date')
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('SavedProperties')
                .where(
                  'title',
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy('date')
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          }
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('SavedProperties')
              .orderBy('date')
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
        }
      } else {
        if (searchText != null && searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('SavedProperties')
                .where('title',
                    isGreaterThanOrEqualTo: searchText,
                    isLessThanOrEqualTo: searchText.substring(
                            0,
                            searchText.length > 1
                                ? (searchText.length - 1)
                                : null) +
                        String.fromCharCode(
                            searchText.codeUnitAt(searchText.length - 1) + 1))
                .orderBy('date')
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('SavedProperties')
                .where(
                  'title',
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy('date')
                .limit(10)
                .get();
          }
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('SavedProperties')
              .orderBy('date')
              .limit(10)
              .get();
        }
      }

      List<String> propertiesIds = [];
      if (snapshot.docs.isNotEmpty) {
        propertiesIds = snapshot.docs
            .map(
              (e) => e.get('propertyId').toString(),
            )
            .toList();
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Properties')
          .where('propertyId', whereIn: [propertiesIds]).get();

      return querySnapshot;
    } catch (e) {
      return null;
    }
  }

  Future<int> getSavedPropertiesCount(String userId) async {
    try {
      AggregateQuerySnapshot snapshot;

      snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('SavedProperties')
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }
}
