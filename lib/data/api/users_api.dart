import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/api/storage_api.dart';
import 'package:next_location/data/model/user_model.dart';
import 'package:next_location/utils/constants.dart';

class UsersApi {
  Future<dynamic> addUser(UserModel model, Uint8List? imgFile) async {
    try {
      if (imgFile != null) {
        String imgUrl = await StorageApi().addToStorage(imgFile, 'UsersImages');
        model.imgUrl = imgUrl;
      }

      Random random = Random();
      int randomNumber = 0;
      int randomNo = 0;
      bool idAvailable = false;
      while (!idAvailable) {
        randomNumber = random.nextInt(1000000000);
        randomNo = 1000000000 + randomNumber;
        bool result = await checkUserSerialAvailability(randomNo);
        if (result) {
          idAvailable = true;
        }
      }
      model.serial = randomNo;
      DocumentReference reference = await FirebaseFirestore.instance
          .collection('Users')
          .add(model.toJson())
          .timeout(Constants.requestsTimeout, onTimeout: () {
        throw 'Timeout';
      });

      reference.update({'userId': reference.id});
      model.userId = reference.id;
      return model;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateUserData(UserModel userModel, Uint8List? imgFile) async {
    try {
      if (imgFile != null) {
        String imgUrl = await StorageApi().addToStorage(imgFile, 'UsersImages');
        userModel.imgUrl = imgUrl;
      }

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userModel.userId)
          .update(userModel.toJson())
          .timeout(Constants.requestsTimeout, onTimeout: () {
        throw 'Timeout';
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<DocumentSnapshot?> getUserByID(String id) async {
    try {
      DocumentSnapshot? documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(id)
          .get()
          .timeout(Constants.requestsTimeout, onTimeout: () {
        throw 'Timeout';
      });

      return documentSnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<DocumentSnapshot?> getUserByNID(String nid, bool approvedOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('nid', isEqualTo: nid)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(Constants.requestsTimeout, onTimeout: () {
          throw 'Timeout';
        });
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('nid', isEqualTo: nid)
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
      debugPrint(e.toString());
      return null;
    }
  }

  Future<DocumentSnapshot?> getUserBySerial(
      int serial, bool approvedOnly) async {
    try {
      QuerySnapshot querySnapshot;
      if (approvedOnly) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('serial', isEqualTo: serial)
            .where('status', isEqualTo: 1)
            .get()
            .timeout(Constants.requestsTimeout, onTimeout: () {
          throw 'Timeout';
        });
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
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
      debugPrint(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot?> getUsers(UserModel? lastModel, int role, String sort,
      bool descending, String searchText, String searchFilter) async {
    QuerySnapshot snapshot;

    try {
      DocumentSnapshot? documentSnapshot;

      if (lastModel != null) {
        if (lastModel.userId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(lastModel.userId)
              .get()
              .timeout(Constants.requestsTimeout, onTimeout: () {
            throw 'Timeout';
          });
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get()
              .timeout(Constants.requestsTimeout, onTimeout: () {
            throw 'Timeout';
          });
          documentSnapshot = querySnapshot.docs.first;
        }

        if (searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
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
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
                .where(
                  searchFilter,
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy(searchFilter, descending: descending)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          }
        } else {
          if (sort == 'createdDate' || sort.isEmpty) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
                .orderBy('createdDate', descending: descending)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
                .orderBy(sort, descending: descending)
                .orderBy('createdDate', descending: true)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          }
        }
      } else {
        if (searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
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
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
                .where(
                  searchFilter,
                  isGreaterThanOrEqualTo: searchText,
                )
                .orderBy(searchFilter, descending: descending)
                .limit(10)
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          }
        } else {
          if (sort == 'createdDate' || sort.isEmpty) {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
                .orderBy('createdDate', descending: descending)
                .limit(10)
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where('status', isEqualTo: 1)
                .where('role', isEqualTo: role)
                .orderBy(sort, descending: descending)
                .orderBy('createdDate', descending: true)
                .limit(10)
                .get()
                .timeout(Constants.requestsTimeout, onTimeout: () {
              throw 'Timeout';
            });
          }
        }
      }

      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<int> getUsersCount(
      String searchText, int role, String searchFilter) async {
    try {
      AggregateQuerySnapshot snapshot;

      if (searchText.isNotEmpty) {
        if (searchText.length > 1) {
          snapshot = await FirebaseFirestore.instance
              .collection('Users')
              .where('status', isEqualTo: 1)
              .where('role', isEqualTo: role)
              .where(searchFilter,
                  isGreaterThanOrEqualTo: searchText,
                  isLessThanOrEqualTo: searchText.substring(
                          0, searchText.length - 1) +
                      (String.fromCharCode(
                          searchText.codeUnitAt(searchText.length - 1) + 1)))
              .count()
              .get()
              .timeout(Constants.requestsTimeout, onTimeout: () {
            throw 'Timeout';
          });
        } else {
          snapshot = await FirebaseFirestore.instance
              .collection('Users')
              .where('status', isEqualTo: 1)
              .where('role', isEqualTo: role)
              .where(
                searchFilter,
                isGreaterThanOrEqualTo: searchText,
              )
              .count()
              .get()
              .timeout(Constants.requestsTimeout, onTimeout: () {
            throw 'Timeout';
          });
        }
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('status', isEqualTo: 1)
            .where('role', isEqualTo: role)
            .count()
            .get()
            .timeout(Constants.requestsTimeout, onTimeout: () {
          throw 'Timeout';
        });
      }

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<bool> requestDeacativation(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userModel.userId)
          .update({'status': 4}).timeout(Constants.requestsTimeout,
              onTimeout: () {
        throw 'Timeout';
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> requestDeletion(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userModel.userId)
          .update({'status': 5}).timeout(Constants.requestsTimeout,
              onTimeout: () {
        throw 'Timeout';
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> checkUserSerialAvailability(int serial) async {
    try {
      QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('serial', isEqualTo: serial)
          .get()
          .timeout(Constants.requestsTimeout, onTimeout: () {
        throw 'Timeout';
      });
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(e.toString());
      return false;
    }
  }
}
