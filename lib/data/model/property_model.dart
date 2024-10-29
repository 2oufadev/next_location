import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/model/image_model.dart';
import 'package:next_location/data/model/video_model.dart';

class PropertyModel {
  String? propertyId, userId, areaId, cityId, propertyTypeId, countryId; // ID's
  String? title, description, address;
  // ids from data base (collection 'PropertiesTypes') ex. for villas >> propertyTypeId = Ue9nln8MziMpfJjviVyG

  Timestamp? createdDate;
  int? bathrooms, bedrooms, livingRooms, guestRooms;
  int? floorsNumber,
      gracePeriod,
      propertyAge,
      propertyFloor,
      totalReviews,
      serial,
      paymentTerm, // [0 = 'monthly', 1 = 'twiceYearly', 2 = 'yearly']
      listingType, // [ 0 = 'rent', 1 = 'sale']
      termType, // [ 0 = 'shortTerm', 1 =  'longTerm', 2 = 'investment']
      furnishingType, // [ 0 = 'furnished', 1 = 'unfurnished', 2 = 'semiFurnished']
      propertyStatus, // [ 0 = available, 1 = occupied, 2 = sold],
      status, // [ 0 = pending, 1 = approved, 2 = rejected, 3 = deleted, 4 = requested deletion ]
      purposeType, // [0 = All Residence, 1 = Family Residence, 2 = Single Residence,  3 = All Commercial]
      storeFronts,
      parkings;

  double? latitude, longitude, price, areaSize, streetWidth, rating;
  List<VideoModel>? videos;
  List<ImageModel>? images;
  List<String>? amenities;
  List<String>? previousUses;

  PropertyModel(
      this.createdDate,
      this.propertyId,
      this.propertyTypeId,
      this.userId,
      this.countryId,
      this.cityId,
      this.areaId,
      this.address,
      this.title,
      this.description,
      this.latitude,
      this.longitude,
      this.areaSize,
      this.price,
      this.videos,
      this.images,
      this.amenities,
      this.previousUses,
      this.furnishingType,
      this.termType,
      this.listingType,
      this.floorsNumber,
      this.gracePeriod,
      this.propertyAge,
      this.propertyFloor,
      this.serial,
      this.propertyStatus,
      this.storeFronts,
      this.parkings,
      this.paymentTerm,
      this.bathrooms,
      this.bedrooms,
      this.livingRooms,
      this.guestRooms,
      this.status,
      this.streetWidth,
      this.purposeType,
      this.rating,
      this.totalReviews);
  PropertyModel.fromJson(Map<String, dynamic> json) {
    propertyId = json['propertyId'] ?? '';
    propertyTypeId = json['propertyTypeId'] ?? '';
    userId = json['userId'] ?? '';
    cityId = json['cityId'] ?? '';
    countryId = json['countryId'] ?? '';
    areaId = json['areaId'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    address = json['address'] ?? '';
    status = json['status'] ?? '';
    bathrooms = json['bathrooms'] ?? 0;
    livingRooms = json['livingRooms'] ?? 0;
    guestRooms = json['guestRooms'] ?? 0;
    bedrooms = json['bedrooms'] ?? 0;
    furnishingType = json['furnishingType'] ?? 0;
    termType = json['termType'] ?? 0;
    listingType = json['listingType'] ?? 0;
    purposeType = json['purposeType'] ?? 0;
    paymentTerm = json['paymentTerm'] ?? 0;
    floorsNumber = json['floorsNumber'] ?? 0;
    gracePeriod = json['gracePeriod'] ?? 0;
    propertyAge = json['propertyAge'] ?? 0;
    propertyFloor = json['propertyFloor'] ?? 0;
    serial = json['serial'] ?? 0;
    propertyStatus = json['propertyStatus'] ?? 0;
    storeFronts = json['storeFronts'] ?? 0;
    parkings = json['parkings'] ?? 0;
    totalReviews = json['totalReviews'] ?? 0;
    if (json['createdDate'] != null) {
      createdDate = json['createdDate'];
    }

    if (json['amenities'] != null) {
      List<dynamic> list = json['amenities'];
      amenities = list.map((e) => e.toString()).toList();
    } else {
      amenities = [];
    }
    if (json['previousUses'] != null) {
      List<dynamic> list = json['previousUses'];
      previousUses = list.map((e) => e.toString()).toList();
    } else {
      previousUses = [];
    }

    if (json['images'] != null) {
      List list = json['images'];
      images = list
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      images = [];
    }
    if (json['latitude'] != null) {
      latitude = json['latitude'] is double
          ? json['latitude']
          : (json['latitude'] as int).toDouble();
    } else {
      latitude = 0.0;
    }

    if (json['rating'] != null) {
      rating = json['rating'] is double
          ? json['rating']
          : (json['rating'] as int).toDouble();
    } else {
      rating = 0.0;
    }
    if (json['longitude'] != null) {
      longitude = json['longitude'] is double
          ? json['longitude']
          : (json['longitude'] as int).toDouble();
    } else {
      longitude = 0.0;
    }
    if (json['price'] != null) {
      price = json['price'] is double
          ? json['price']
          : (json['price'] as int).toDouble();
    } else {
      price = 0.0;
    }
    if (json['areaSize'] != null) {
      areaSize = json['areaSize'] is double
          ? json['areaSize']
          : (json['areaSize'] as int).toDouble();
    } else {
      areaSize = 0.0;
    }

    if (json['streetWidth'] != null) {
      streetWidth = json['streetWidth'] is double
          ? json['streetWidth']
          : (json['streetWidth'] as int).toDouble();
    } else {
      streetWidth = 0.0;
    }

    if (json['videos'] != null) {
      List list = json['videos'];
      videos = list
          .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      videos = [];
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (propertyId != null) data['propertyId'] = propertyId;
    if (propertyTypeId != null) data['propertyTypeId'] = propertyTypeId;
    if (userId != null) data['userId'] = userId;
    if (areaId != null) data['areaId'] = areaId;
    if (cityId != null) data['cityId'] = cityId;
    if (countryId != null) data['countryId'] = countryId;
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (address != null) data['address'] = address;
    if (status != null) data['status'] = status;
    if (bathrooms != null) data['bathrooms'] = bathrooms;
    if (guestRooms != null) data['guestRooms'] = guestRooms;
    if (livingRooms != null) data['livingRooms'] = livingRooms;
    if (bedrooms != null) data['bedrooms'] = bedrooms;
    if (listingType != null) data['listingType'] = listingType;
    if (furnishingType != null) data['furnishingType'] = furnishingType;
    if (termType != null) data['termType'] = termType;
    if (paymentTerm != null) data['paymentTerm'] = paymentTerm;
    if (gracePeriod != null) data['gracePeriod'] = gracePeriod;
    if (propertyAge != null) data['propertyAge'] = propertyAge;
    if (purposeType != null) data['purposeType'] = purposeType;
    if (propertyFloor != null) data['propertyFloor'] = propertyFloor;
    if (serial != null) data['serial'] = serial;
    if (propertyStatus != null) data['propertyStatus'] = propertyStatus;
    if (storeFronts != null) data['storeFronts'] = storeFronts;
    if (parkings != null) data['parkings'] = parkings;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (createdDate != null) data['createdDate'] = createdDate;
    if (floorsNumber != null) data['floorsNumber'] = floorsNumber;
    if (areaSize != null) data['areaSize'] = areaSize;
    if (price != null) data['price'] = price;
    if (streetWidth != null) data['streetWidth'] = streetWidth;
    if (amenities != null) data['amenities'] = amenities;
    if (rating != null) data['rating'] = rating;
    if (totalReviews != null) data['totalReviews'] = totalReviews;
    if (images != null) {
      data['images'] = images!.map((e) => e.toJson());
    }

    if (previousUses != null) data['previousUses'] = previousUses;

    if (videos != null) {
      data['videos'] = videos!.map((e) => e.toJson());
    }

    return data;
  }
}
