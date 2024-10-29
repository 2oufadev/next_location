import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/offers_api.dart';
import 'package:next_location/data/model/offers_model.dart';

class OffersRepository {
  Future<OffersModel?> getOfferById(String id) async {
    DocumentSnapshot? documentSnapshot = await OffersApi().getOfferById(id);
    OffersModel? offersModel;
    if (documentSnapshot != null && documentSnapshot.exists) {
      offersModel =
          OffersModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
    return offersModel;
  }

  Future<dynamic> addOffer(OffersModel model) async {
    return await OffersApi().addOffer(model);
  }

  Future<dynamic> editOffer(OffersModel model) async {
    return await OffersApi().editOffer(model);
  }

  // status options [null = all status, 0 = pending, 1 = accepted, 2 = rejected, 3 = canceled]
  Future<List<OffersModel>> getUsersOffers(String userId,
      OffersModel? lastModel, bool descending, int? status) async {
    List<OffersModel> offersList = [];
    QuerySnapshot? querySnapshot =
        await OffersApi().getUsersOffers(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      offersList = querySnapshot.docs
          .map(
            (e) => OffersModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return offersList;
  }

  Future<int> getUsersOffersCount(String userId, int? status) async {
    return await OffersApi().getUsersOffersCount(userId, status);
  }

  // status options [null = all status, 0 = pending, 1 = accepted, 2 = rejected, 3 = canceled]
  Future<List<OffersModel>> getOwnersOffers(String userId,
      OffersModel? lastModel, bool descending, int? status) async {
    List<OffersModel> offersList = [];
    QuerySnapshot? querySnapshot = await OffersApi()
        .getOwnersOffers(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      offersList = querySnapshot.docs
          .map(
            (e) => OffersModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return offersList;
  }

  Future<int> getOwnersOffersCount(String userId, int? status) async {
    return await OffersRepository().getOwnersOffersCount(userId, status);
  }

  // status options [null = all status, 0 = pending, 1 = accepted, 2 = rejected, 3 = canceled]
  Future<List<OffersModel>> getPropertysOffers(String propertyId,
      OffersModel? lastModel, bool descending, int? status) async {
    List<OffersModel> offersList = [];
    QuerySnapshot? querySnapshot = await OffersApi()
        .getPropertysOffers(propertyId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      offersList = querySnapshot.docs
          .map(
            (e) => OffersModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return offersList;
  }

  Future<int> getPropertysOffersCount(String propertyId, int? status) async {
    return await OffersRepository().getPropertysOffersCount(propertyId, status);
  }
}
