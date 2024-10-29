class AmenitiesModel {
  String? title, titleAr, amenityId;
  bool? available;
  int? order;
  List<String>?
      propertyTypes; // List of properties types id that will be allowed to select this amenity
  AmenitiesModel(this.order, this.title, this.titleAr, this.amenityId,
      this.available, this.propertyTypes);
  AmenitiesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    titleAr = json['titleAr'] ?? '';
    amenityId = json['amenityId'] ?? '';
    order = json['order'] ?? 0;
    available = json['available'] ?? false;
    if (json['propertyTypes'] != null) {
      List<dynamic> list = json['propertyTypes'];
      propertyTypes = list.map((e) => e.toString()).toList();
    } else {
      propertyTypes = [];
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (title != null) data['title'] = title;
    if (titleAr != null) data['titleAr'] = titleAr;
    if (amenityId != null) data['amenityId'] = amenityId;
    if (order != null) data['order'] = order;
    if (available != null) data['available'] = available;
    if (propertyTypes != null) data['propertyTypes'] = propertyTypes;

    return data;
  }
}
