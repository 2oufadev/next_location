class CityModel {
  String? cityId, countryId, title, titleAr;
  int? serial, order;
  bool? available;

  CityModel(this.cityId, this.countryId, this.title, this.titleAr, this.serial,
      this.available, this.order);

  CityModel.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'] ?? '';
    countryId = json['countryId'] ?? '';
    title = json['title'] ?? '';
    titleAr = json['titleAr'] ?? '';
    serial = json['serial'] ?? 0;
    order = json['order'] ?? 0;

    available = json['available'] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (cityId != null) data['cityId'] = cityId;
    if (countryId != null) data['countryId'] = countryId;
    if (title != null) data['title'] = title;
    if (titleAr != null) data['titleAr'] = titleAr;
    if (available != null) data['available'] = available;
    if (serial != null) data['serial'] = serial;
    if (order != null) data['order'] = order;

    return data;
  }
}
