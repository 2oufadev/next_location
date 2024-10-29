import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/visits_api.dart';
import 'package:next_location/data/model/visit_model.dart';

class VisitsRepository {
  // End Users
  Future<dynamic> addVisit(VisitModel model) async {
    return await VisitsApi().bookAVisit(model);
  }

  // status options [null = all status, 0 = requested, 1 = approved, 2 = rejected, 3 = canceled, 4 = rescheduled]
  Future<List<VisitModel>> getUsersVisits(String userId, VisitModel? lastModel,
      bool descending, int? status) async {
    List<VisitModel> visitsList = [];
    QuerySnapshot? querySnapshot =
        await VisitsApi().getUsersVisits(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => VisitModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<List<VisitModel>> getUsersPrevVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    List<VisitModel> visitsList = [];
    QuerySnapshot? querySnapshot = await VisitsApi()
        .getUsersPrevVisits(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => VisitModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<List<VisitModel>> getUsersUpcomingVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    List<VisitModel> visitsList = [];
    QuerySnapshot? querySnapshot = await VisitsApi()
        .getUsersUpcomingVisits(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => VisitModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<int> getUsersVisitsCount(String userId, int? status) async {
    return await VisitsApi().getUsersVisitsCount(userId, status);
  }

  Future<int> getUsersPrevVisitsCount(String userId, int? status) async {
    return await VisitsApi().getUsersPrevVisitsCount(userId, status);
  }

  Future<int> getUsersUpcomingVisitsCount(String userId, int? status) async {
    return await VisitsApi().getUsersUpcomingVisitsCount(userId, status);
  }

  Future cancelVisit(VisitModel model) async {
    return await VisitsApi().cancelVisit(
      model,
    );
  }

  // Owners & Real Estate Users
  Future<dynamic> approveAVisit(VisitModel model) async {
    return await VisitsApi().approveAVisit(model);
  }

  Future<dynamic> rejectAVisit(VisitModel model) async {
    return await VisitsApi().rejectAVisit(model);
  }

  Future<dynamic> rescheduleAVisit(VisitModel model, Timestamp newDate) async {
    return await VisitsApi().rescheduleAVisit(model, newDate);
  }

  // status options [null = all status, 0 = requested, 1 = approved, 2 = rejected, 3 = canceled, 4 = rescheduled]
  Future<List<VisitModel>> getOwnersVisits(String userId, VisitModel? lastModel,
      bool descending, int? status) async {
    List<VisitModel> visitsList = [];
    QuerySnapshot? querySnapshot = await VisitsApi()
        .getOwnersVisits(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => VisitModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<List<VisitModel>> getOwnersPrevVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    List<VisitModel> visitsList = [];
    QuerySnapshot? querySnapshot = await VisitsApi()
        .getOwnersPrevVisits(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => VisitModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<List<VisitModel>> getOwnersUpcomingVisits(String userId,
      VisitModel? lastModel, bool descending, int? status) async {
    List<VisitModel> visitsList = [];
    QuerySnapshot? querySnapshot = await VisitsApi()
        .getOwnersUpcomingVisits(userId, lastModel, descending, status);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      visitsList = querySnapshot.docs
          .map(
            (e) => VisitModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return visitsList;
  }

  Future<int> getOwnersVisitsCount(String userId, int? status) async {
    return await VisitsApi().getOwnersVisitsCount(userId, status);
  }

  Future<int> getOwnersPrevVisitsCount(String userId, int? status) async {
    return await VisitsApi().getOwnersPrevVisitsCount(userId, status);
  }

  Future<int> getOwnersUpcomingVisitsCount(String userId, int? status) async {
    return await VisitsApi().getOwnersUpcomingVisitsCount(userId, status);
  }
}
