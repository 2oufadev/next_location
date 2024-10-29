import 'package:cloud_firestore/cloud_firestore.dart';

class VisitModel {
  String? areaId,
      cityId,
      countryId,
      message,
      ownerId,
      propertyId,
      userId,
      visitId;

  int? serial,
      status; // [0 = requested, 1 = approved, 2 = rejected, 3 = canceled, 4 = rescheduled]
  Timestamp? date, createdDate;

  VisitModel(
      this.areaId,
      this.cityId,
      this.countryId,
      this.message,
      this.ownerId,
      this.propertyId,
      this.userId,
      this.visitId,
      this.serial,
      this.status,
      this.date,
      this.createdDate);

  VisitModel.fromJson(Map<String, dynamic> json) {
    areaId = json['areaId'] ?? '';
    cityId = json['cityId'] ?? '';
    countryId = json['countryId'] ?? '';
    message = json['message'] ?? '';
    ownerId = json['ownerId'] ?? '';
    propertyId = json['propertyId'] ?? '';
    userId = json['userId'] ?? '';
    visitId = json['visitId'] ?? '';

    serial = json['serial'] ?? 0;
    status = json['status'] ?? 0;
    date = json['date'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['areaId'] = areaId ?? '';
    data['cityId'] = cityId ?? '';
    data['countryId'] = countryId ?? '';
    data['message'] = message ?? '';
    data['ownerId'] = ownerId ?? '';
    data['propertyId'] = propertyId ?? '';
    data['userId'] = userId ?? '';
    data['visitId'] = visitId ?? '';

    data['serial'] = serial ?? 0;
    data['status'] = status ?? 0;
    data['date'] = date;
    data['createdDate'] = createdDate;

    return data;
  }
}
