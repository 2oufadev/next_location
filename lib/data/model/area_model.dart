class AreaModel {
  String? cityId, areaId, title, titleAr;
  int? serial, order;
  bool? available;

  AreaModel(this.cityId, this.areaId, this.title, this.titleAr, this.serial,
      this.available, this.order);

  AreaModel.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'] ?? '';
    areaId = json['areaId'] ?? '';
    title = json['title'] ?? '';
    titleAr = json['titleAr'] ?? '';
    serial = json['serial'] ?? 0;
    order = json['order'] ?? 0;

    available = json['available'] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (cityId != null) data['cityId'] = cityId;
    if (areaId != null) data['areaId'] = areaId;
    if (title != null) data['title'] = title;
    if (titleAr != null) data['titleAr'] = titleAr;
    if (available != null) data['available'] = available;
    if (serial != null) data['serial'] = serial;
    if (order != null) data['order'] = order;

    return data;
  }
}
