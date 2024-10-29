import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId,
      cityId,
      countryId,
      nid,
      licenseNumber,
      commercialRegNumber,
      representativeRole,
      areaId,
      imgUrl,
      userName,
      email,
      phone,
      address,
      firebaseUID, // firebase user UID
      notificationToken; // notification token from firebase messaging
  int? serial,
      role, // [0 = user , 1 = agent, 2 = owner, 3 = real estate manager]
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
      this.areaId,
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
    areaId = json['areaId'] ?? '';
    firebaseUID = json['firebaseUID'] ?? '';
    notificationToken = json['notificationToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (userId != null) data['userId'] = userId;
    if (cityId != null) data['cityId'] = cityId;
    if (licenseNumber != null) data['licenseNumber'] = licenseNumber;
    if (commercialRegNumber != null)
      data['commercialRegNumber'] = commercialRegNumber;
    if (lastActiveDate != null) data['lastActiveDate'] = lastActiveDate;
    if (imgUrl != null) data['imgUrl'] = imgUrl;
    if (userName != null) data['userName'] = userName;
    if (dateOfBirth != null) data['dateOfBirth'] = dateOfBirth;
    if (role != null) data['role'] = role;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (nid != null) data['nid'] = nid;
    if (status != null) data['status'] = status;
    if (role != null) data['role'] = role;
    if (createdDate != null) data['createdDate'] = createdDate;
    if (serial != null) data['serial'] = serial;
    if (online != null) data['online'] = online;
    if (representativeRole != null)
      data['representativeRole'] = representativeRole;
    if (address != null) data['address'] = address;
    if (areaId != null) data['areaId'] = areaId;
    if (countryId != null) data['countryId'] = countryId;
    if (notificationToken != null)
      data['notificationToken'] = notificationToken;
    if (firebaseUID != null) data['firebaseUID'] = firebaseUID;

    return data;
  }
}
