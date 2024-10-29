import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/countries_api.dart';
import 'package:next_location/data/model/country_model.dart';

class CountriesRepository {
  Future<CountryModel?> getCountryById(String id) async {
    DocumentSnapshot? documentSnapshot =
        await CountriesApi().getCountryById(id);

    CountryModel? countryModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      countryModel = CountryModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }

    return countryModel;
  }

  Future<CountryModel?> getCountryBySerial(
      int serial, bool availableOnly) async {
    DocumentSnapshot? documentSnapshot =
        await CountriesApi().getCountryBySerial(serial, availableOnly);

    CountryModel? countryModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      countryModel = CountryModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }

    return countryModel;
  }

  Future<List<CountryModel>> getAllCountries(bool availableOnly) async {
    QuerySnapshot? querySnapshot;
    List<CountryModel> countries = [];

    querySnapshot = await CountriesApi().getAllCountries(availableOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      countries = querySnapshot.docs
          .map(
            (e) => CountryModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return countries;
  }
}
