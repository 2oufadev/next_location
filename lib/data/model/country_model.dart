class CountryModel {
  String? countryCode, countryId, flag, title, titleAr;
  int? serial, order;
  bool? available;

  CountryModel(this.countryId, this.countryCode, this.flag, this.title,
      this.titleAr, this.serial, this.available, this.order);

  CountryModel.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'] ?? '';
    countryCode = json['countryCode'] ?? '';
    flag = json['flag'] ?? '';
    title = json['title'] ?? '';
    titleAr = json['titleAr'] ?? '';
    serial = json['serial'] ?? 0;
    order = json['order'] ?? 0;
    available = json['available'] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if (countryId != null) data['countryId'] = countryId;
    if (countryCode != null) data['countryCode'] = countryCode;
    if (flag != null) data['flag'] = flag;
    if (title != null) data['title'] = title;
    if (titleAr != null) data['titleAr'] = titleAr;
    if (serial != null) data['serial'] = serial;
    if (order != null) data['order'] = order;
    if (available != null) data['available'] = available;
    return data;
  }
}
