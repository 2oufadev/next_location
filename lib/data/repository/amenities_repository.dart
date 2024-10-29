import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/amenities_api.dart';
import 'package:next_location/data/model/amenities_model.dart';

class AmenitiesRepository {
  Future<List<AmenitiesModel>> getAllAmenities(bool availableOnly) async {
    QuerySnapshot? querySnapshot;
    List<AmenitiesModel> amenitiesList = [];
    querySnapshot = await AmenitiesApi().getAllAmenities(availableOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      amenitiesList = querySnapshot.docs
          .map(
            (e) => AmenitiesModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return amenitiesList;
  }

  Future<List<AmenitiesModel>> getPropertyTypesAmenities(
      String propertyTypeId, bool availableOnly) async {
    QuerySnapshot? querySnapshot;
    List<AmenitiesModel> amenitiesList = [];
    querySnapshot = await AmenitiesApi()
        .getPropertyTypesAmenities(propertyTypeId, availableOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      amenitiesList = querySnapshot.docs
          .map(
            (e) => AmenitiesModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return amenitiesList;
  }

  Future<AmenitiesModel?> getAmenityByID(
    String amenityId,
  ) async {
    DocumentSnapshot? documentSnapshot;
    AmenitiesModel? amenityModel;
    documentSnapshot = await AmenitiesApi().getAmenityByID(amenityId);
    if (documentSnapshot != null && documentSnapshot.exists) {
      amenityModel = AmenitiesModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }
    return amenityModel;
  }
}
