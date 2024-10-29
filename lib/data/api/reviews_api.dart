import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/model/property_model.dart';
import 'package:next_location/data/model/review_model.dart';
import 'package:next_location/utils/constants.dart';

class ReviewsApi {
  Future<int> getPropertyReviewsCount(String propertyId) async {
    try {
      AggregateQuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Reviews')
          .where('propertyId', isEqualTo: propertyId)
          .where(
            'status',
            isEqualTo: 1,
          )
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  Future<DocumentSnapshot?> getReviewById(String id) async {
    try {
      DocumentSnapshot? documentSnapshot =
          await FirebaseFirestore.instance.collection('Reviews').doc(id).get();

      return documentSnapshot;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool?> placePropertyReview(
      PropertyModel propertyModel, ReviewModel reviewModel) async {
    try {
      DocumentReference reference = await FirebaseFirestore.instance
          .collection('Reviews')
          .add(reviewModel.toJson());
      reference.update({'reviewId': reference.id});

      int numberOfReviews = propertyModel.totalReviews ?? 0;
      double averageRate = propertyModel.rating ?? 0.0;

      double newRate = ((numberOfReviews * averageRate) +
              (reviewModel.totalReviewRate ?? 0.0)) /
          (numberOfReviews + 1);
      await FirebaseFirestore.instance
          .collection('Properties')
          .doc(propertyModel.propertyId)
          .set({'rating': newRate, 'totalReviews': FieldValue.increment(1)},
              SetOptions(merge: true));

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<QuerySnapshot?> getPropertyReviews(
      String propertyId,
      ReviewModel? lastModel,
      String filter,
      bool descending,
      String searchText,
      String searchFilter) async {
    QuerySnapshot snapshot;

    try {
      DocumentSnapshot? documentSnapshot;

      if (lastModel != null) {
        if (lastModel.userId!.isNotEmpty) {
          documentSnapshot = await FirebaseFirestore.instance
              .collection('Reviews')
              .doc(lastModel.userId)
              .get();
        } else {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Reviews')
              .where('createdDate', isEqualTo: lastModel.createdDate!)
              .get();
          documentSnapshot = querySnapshot.docs.first;
        }

        if (searchText.isNotEmpty) {
          if (searchText.length > 1) {
            snapshot = await FirebaseFirestore.instance
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
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
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
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
          if (filter == 'createdDate' || filter == '') {
            snapshot = await FirebaseFirestore.instance
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
                .where('status', isEqualTo: 1)
                .orderBy('createdDate', descending: descending)
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
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
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
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
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
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
          if (filter == 'createdDate' || filter == '') {
            snapshot = await FirebaseFirestore.instance
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
                .where('status', isEqualTo: 1)
                .orderBy('createdDate', descending: descending)
                .limit(10)
                .get();
          } else {
            snapshot = await FirebaseFirestore.instance
                .collection('Reviews')
                .where('propertyId', isEqualTo: propertyId)
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
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> requestReviewDeletion(ReviewModel reviewModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('Reviews')
          .doc(reviewModel.reviewId)
          .update({'status': 4}).timeout(
        Constants.requestsTimeout,
        onTimeout: () {
          throw 'Time Out';
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
