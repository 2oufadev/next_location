import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/areas_api.dart';
import 'package:next_location/data/model/area_model.dart';

class AreasRepository {
  Future<AreaModel?> getAreaByID(String id) async {
    DocumentSnapshot? documentSnapshot = await AreasApi().getAreaByID(id);

    AreaModel? areaModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      areaModel =
          AreaModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return areaModel;
  }

  Future<AreaModel?> getAreaBySerial(int serial, bool availableOnly) async {
    DocumentSnapshot? documentSnapshot =
        await AreasApi().getAreaBySerial(serial, availableOnly);

    AreaModel? areaModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      areaModel =
          AreaModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return areaModel;
  }

  Future<List<AreaModel>> getCitysAreas(
      String cityId, bool availableOnly) async {
    QuerySnapshot? querySnapshots =
        await AreasApi().getCitysAreas(cityId, availableOnly);

    List<AreaModel>? areasList = [];

    if (querySnapshots != null && querySnapshots.docs.isNotEmpty) {
      areasList = querySnapshots.docs
          .map(
            (e) => AreaModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return areasList;
  }

  Future<List<AreaModel>> getAllAreas(bool availableOnly) async {
    List<AreaModel> areasList = [];

    QuerySnapshot? querySnapshot = await AreasApi().getAllAreas(availableOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      areasList = querySnapshot.docs
          .map(
            (e) => AreaModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return areasList;
  }
}
