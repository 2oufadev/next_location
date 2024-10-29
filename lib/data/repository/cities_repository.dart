import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/cities_api.dart';
import 'package:next_location/data/model/city_model.dart';

class CitiesRepository {
  Future<CityModel?> getCityByID(String id) async {
    DocumentSnapshot? documentSnapshot = await CitiesApi().getCityByID(id);

    CityModel? cityModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      cityModel =
          CityModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return cityModel;
  }

  Future<CityModel?> getCityBySerial(int serial, bool availableOnly) async {
    DocumentSnapshot? documentSnapshot =
        await CitiesApi().getCityBySerial(serial, availableOnly);

    CityModel? cityModel;
    if (documentSnapshot != null && documentSnapshot.exists) {
      cityModel =
          CityModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
    return cityModel;
  }

  Future<List<CityModel>> getCountrysCities(
      String countryId, bool availableOnly) async {
    QuerySnapshot? querySnapshot =
        await CitiesApi().getCountrysCities(countryId, availableOnly);

    List<CityModel> citiesList = [];
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      citiesList = querySnapshot.docs
          .map(
            (e) => CityModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return citiesList;
  }

  Future<List<CityModel>> getAllCities(bool availableOnly) async {
    QuerySnapshot? querySnapshot =
        await CitiesApi().getAllCities(availableOnly);
    List<CityModel> citiesList = [];
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      citiesList = querySnapshot.docs
          .map(
            (e) => CityModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return citiesList;
  }
}
