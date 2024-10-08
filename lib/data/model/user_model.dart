import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId,
      cityId,
      countryId,
      nid,
      licenseNumber,
      commercialRegNumber,
      representativeRole,
      area,
      imgUrl,
      userName,
      email,
      phone,
      address,
      firebaseUID, // firebase user UID
      notificationToken; // notification token from firebase messaging
  int? serial,
      role, // [0 = customer , 1 = agent, 2 = owner]
      status; // [0 = 'pending', 1 = 'approved', 2 = 'rejected', 3 = 'deactivated', 4 = 'requestedDeactivation', 5 = 'requestedDeletion']

  bool? online;
  Timestamp? lastActiveDate, createdDate, dateOfBirth;

  UserModel(
      this.userId,
      this.licenseNumber,
      this.commercialRegNumber,
      this.lastActiveDate,
      this.imgUrl,
      this.userName,
      this.role,
      this.email,
      this.phone,
      this.nid,
      this.status,
      this.createdDate,
      this.online,
      this.countryId,
      this.address,
      this.area,
      this.cityId,
      this.dateOfBirth,
      this.representativeRole,
      this.serial,
      this.firebaseUID,
      this.notificationToken);

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? '';
    cityId = json['cityId'] ?? '';
    licenseNumber = json['licenseNumber'] ?? '';
    commercialRegNumber = json['commercialRegNumber'] ?? '';
    lastActiveDate = json['lastActiveDate'];
    dateOfBirth = json['dateOfBirth'];
    createdDate = json['createdDate'];
    imgUrl = json['imgUrl'] ?? '';
    userName = json['userName'] ?? '';
    role = json['role'] ?? 0;
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    representativeRole = json['representativeRole'] ?? '';
    nid = json['nid'] ?? '';
    status = json['status'] ?? 0;
    role = json['role'] ?? '';
    serial = json['serial'] ?? 0;
    online = json['online'] ?? false;
    countryId = json['countryId'] ?? '';
    address = json['address'] ?? '';
    area = json['area'] ?? '';
    firebaseUID = json['firebaseUID'] ?? '';
    notificationToken = json['notificationToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['userId'] = userId ?? '';
    data['cityId'] = cityId ?? '';
    data['licenseNumber'] = licenseNumber ?? '';
    data['commercialRegNumber'] = commercialRegNumber ?? '';
    data['imgUrl'] = imgUrl ?? '';
    data['userName'] = userName ?? '';
    data['dateOfBirth'] = dateOfBirth;
    data['lastActiveDate'] = lastActiveDate;
    data['createdDate'] = createdDate;
    data['role'] = role ?? '';
    data['email'] = email ?? '';
    data['phone'] = phone ?? '';
    data['nid'] = nid ?? '';
    data['status'] = status ?? 0;
    data['role'] = role ?? 0;
    data['serial'] = serial ?? 0;
    data['online'] = online ?? false;
    data['representativeRole'] = representativeRole ?? '';
    data['address'] = address ?? '';
    data['area'] = area ?? '';
    data['countryId'] = countryId ?? '';
    data['notificationToken'] = notificationToken ?? '';
    data['firebaseUID'] = firebaseUID ?? '';

    return data;
  }
}
