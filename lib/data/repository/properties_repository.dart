import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/properties_api.dart';
import 'package:next_location/data/model/property_model.dart';
import 'package:next_location/data/model/property_types_model.dart';

class PropertiesRepository {
  Future<List<PropertyModel>> getUsersProperties(
      String userId, bool approvedOnly) async {
    List<PropertyModel> propertiesList = [];
    QuerySnapshot? querySnapshot =
        await PropertiesApi().getUsersProperties(userId, approvedOnly);

    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      propertiesList = querySnapshot.docs
          .map(
            (e) => PropertyModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return propertiesList;
  }

  Future<dynamic> addProperty(PropertyModel model) async {
    return await PropertiesApi().addProperty(model);
  }

  Future<dynamic> editProperty(PropertyModel model) async {
    return await PropertiesApi().editProperty(model);
  }

  Future<PropertyModel?> getPropertyById(String id) async {
    PropertyModel? propertyModel;

    DocumentSnapshot? documentSnapshot =
        await PropertiesApi().getPropertyById(id);
    if (documentSnapshot != null && documentSnapshot.exists) {
      propertyModel = PropertyModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }
    return propertyModel;
  }

  // Filters [createdDate, areaSize, serial, propertyTypeId, title, rooms, bedrooms,
  //          guestRooms, floorsNumber, listingType, livingRooms, furnishingType,
  //          bathrooms, price, propertyAge, propertyFloor, propertyStatus, purposeType
  //          status, description, amenities, parkings]
  // searchFilters = [title, address ]
  // descending = [asc, desc]
  Future<List<PropertyModel>> getProperties(
      PropertyModel? lastModel,
      String filter,
      bool descending,
      String searchText,
      String searchFilter) async {
    List<PropertyModel> propertiesList = [];

    QuerySnapshot? querySnapshot = await PropertiesApi()
        .getProperties(lastModel, filter, descending, searchText, searchFilter);

    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      propertiesList = querySnapshot.docs
          .map(
            (e) => PropertyModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return propertiesList;
  }

  Future<int> getPropertiesCount(String searchText, String searchFilter) async {
    return await PropertiesApi().getPropertiesCount(searchText, searchFilter);
  }

  Future<PropertyModel?> getPropertyBySerial(int serial) async {
    PropertyModel? propertyModel;

    DocumentSnapshot? documentSnapshot =
        await PropertiesApi().getPropertyBySerial(serial);
    if (documentSnapshot != null && documentSnapshot.exists) {
      propertyModel = PropertyModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }
    return propertyModel;
  }

  Future<List<PropertyTypesModel>> getPropertiesTypes() async {
    List<PropertyTypesModel> propertiesModelsList = [];
    QuerySnapshot? querySnapshot = await PropertiesApi().getPropertiesTypes();

    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      propertiesModelsList = querySnapshot.docs
          .map(
            (e) =>
                PropertyTypesModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return propertiesModelsList;
  }

  Future<List<PropertyTypesModel>> getAllResidencePropertiesTypes() async {
    List<PropertyTypesModel> propertiesModelsList = [];
    QuerySnapshot? querySnapshot =
        await PropertiesApi().getAllResidencePropertiesTypes();

    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      propertiesModelsList = querySnapshot.docs
          .map(
            (e) =>
                PropertyTypesModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return propertiesModelsList;
  }

  Future<List<PropertyTypesModel>> getFamilyResidencePropertiesTypes() async {
    List<PropertyTypesModel> propertiesModelsList = [];
    QuerySnapshot? querySnapshot =
        await PropertiesApi().getFamilyResidencePropertiesTypes();

    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      propertiesModelsList = querySnapshot.docs
          .map(
            (e) =>
                PropertyTypesModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return propertiesModelsList;
  }

  Future<List<PropertyTypesModel>> getSingleResidencePropertiesTypes() async {
    List<PropertyTypesModel> propertiesModelsList = [];
    QuerySnapshot? querySnapshot =
        await PropertiesApi().getSingleResidencePropertiesTypes();

    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      propertiesModelsList = querySnapshot.docs
          .map(
            (e) =>
                PropertyTypesModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return propertiesModelsList;
  }

  Future<List<PropertyTypesModel>> getAllCommercialPropertiesTypes() async {
    List<PropertyTypesModel> propertiesModelsList = [];
    QuerySnapshot? querySnapshot =
        await PropertiesApi().getAllCommercialPropertiesTypes();

    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      propertiesModelsList = querySnapshot.docs
          .map(
            (e) =>
                PropertyTypesModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return propertiesModelsList;
  }

  Future<bool> requestPropertyDeletion(PropertyModel model) async {
    return await PropertiesApi().requestPropertyDeletion(model);
  }

  Future<bool> deleteProperty(PropertyModel model) async {
    return await PropertiesApi().deleteProperty(model);
  }
}
