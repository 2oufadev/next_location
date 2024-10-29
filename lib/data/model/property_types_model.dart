class PropertyTypesModel {
  String? title, titleAr, propertyTypeId;
  int? order;
  bool? available;
  int?
      type; // [ 0 = All Residence , 1 = Family Residence , 2 = Single Residence, 3 = All Commercials]
  PropertyTypesModel(this.order, this.type, this.title, this.titleAr,
      this.propertyTypeId, this.available);
  PropertyTypesModel.fromJson(Map<String, dynamic> json) {
    propertyTypeId = json['propertyTypeId'] ?? '';
    type = json['type'] ?? 0;
    title = json['title'] ?? '';
    titleAr = json['titleAr'] ?? '';
    order = json['order'] ?? 0;
    available = json['available'] ?? false;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (propertyTypeId != null) data['propertyTypeId'] = propertyTypeId;
    if (type != null) data['type'] = type;
    if (title != null) data['title'] = title;
    if (titleAr != null) data['titleAr'] = titleAr;
    if (order != null) data['order'] = order;
    if (available != null) data['available'] = available;
    return data;
  }
}
