import 'package:cloud_firestore/cloud_firestore.dart';

class ListingModel {
  String? listingId, propertyId, userId, status;

  double? price;
  int? listingType;
  Timestamp? createdDate, startDate, endDate;
  ListingModel(
    this.listingId,
    this.propertyId,
    this.userId,
    this.status,
    this.price,
    this.listingType,
    this.createdDate,
    this.startDate,
    this.endDate,
  );

  ListingModel.fromJson(Map<String, dynamic> json) {
    listingId = json['listingId'] ?? '';
    propertyId = json['propertyId'] ?? '';
    userId = json['userId'] ?? '';
    status = json['status'] ?? '';
    price = json['price'] ?? 0.0;

    listingType = json['listingType'] ?? 0;
    createdDate = json['createdDate'] ?? 0;
    startDate = json['startDate'] ?? 0;

    endDate = json['endDate'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['listingId'] = listingId ?? '';
    data['propertyId'] = propertyId ?? '';
    data['userId'] = userId ?? '';
    data['status'] = status ?? '';
    data['price'] = price ?? 0.0;

    data['listingType'] = listingType ?? 0;
    data['createdDate'] = createdDate ?? 0;

    data['startDate'] = startDate ?? 0;
    data['endDate'] = endDate ?? 0;

    return data;
  }
}
