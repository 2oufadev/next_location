import 'package:cloud_firestore/cloud_firestore.dart';

class OffersModel {
  String? offerId, propertyId, userId, ownerId, propertyImgUrl, propertyTitle;

  double? offerValue, currentValue;
  int? serial,
      status; // [0 = pending ,  1 =  accepted , 2 = rejected, 3 = canceled]
  Timestamp? createdDate;

  OffersModel(
      this.offerId,
      this.propertyId,
      this.userId,
      this.ownerId,
      this.propertyImgUrl,
      this.propertyTitle,
      this.offerValue,
      this.currentValue,
      this.serial,
      this.status,
      this.createdDate);

  OffersModel.fromJson(Map<String, dynamic> json) {
    offerId = json['offerId'] ?? '';
    propertyId = json['propertyId'] ?? '';
    userId = json['userId'] ?? '';
    ownerId = json['ownerId'] ?? '';
    propertyImgUrl = json['propertyImgUrl'] ?? '';
    propertyTitle = json['propertyTitle'] ?? '';
    serial = json['serial'] ?? 0;
    status = json['status'] ?? 0;
    createdDate = json['createdDate'];
    if (json['offerValue'] != null) {
      offerValue = json['offerValue'] is double
          ? json['offerValue']
          : (json['offerValue'] as int).toDouble();
    } else {
      offerValue = 0.0;
    }
    if (json['currentValue'] != null) {
      currentValue = json['currentValue'] is double
          ? json['currentValue']
          : (json['currentValue'] as int).toDouble();
    } else {
      currentValue = 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (offerId != null) data['offerId'] = offerId;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (userId != null) data['userId'] = userId;
    if (ownerId != null) data['ownerId'] = ownerId;
    if (propertyTitle != null) data['propertyTitle'] = propertyTitle;
    if (propertyImgUrl != null) data['propertyImgUrl'] = propertyImgUrl;
    if (offerValue != null) data['offerValue'] = offerValue;
    if (currentValue != null) data['currentValue'] = currentValue;
    if (status != null) data['status'] = status;
    if (serial != null) data['serial'] = serial;
    if (createdDate != null) data['createdDate'] = createdDate;

    return data;
  }
}
