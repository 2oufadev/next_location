class ContractUserModel {
  String? userId, countryId, cityId, userName, mobileNumber, idNumber, idType;
  int? role; // 0 = user, 1 = agent, 2 = owner, 3 = realEstateManager

  ContractUserModel(this.userId, this.role, this.countryId, this.cityId,
      this.userName, this.mobileNumber, this.idNumber, this.idType);

  ContractUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? '';
    role = json['role'] ?? 0;
    countryId = json['countryId'] ?? '';
    cityId = json['cityId'] ?? '';
    userName = json['userName'] ?? '';
    mobileNumber = json['mobileNumber'] ?? '';
    idNumber = json['idNumber'] ?? '';
    idType = json['idType'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (userId != null) data['userId'] = userId;
    if (role != null) data['role'] = role;
    if (countryId != null) data['countryId'] = countryId;
    if (cityId != null) data['cityId'] = cityId;
    if (userName != null) data['userName'] = userName;
    if (mobileNumber != null) data['mobileNumber'] = mobileNumber;
    if (idType != null) data['idType'] = idType;
    if (idNumber != null) data['idNumber'] = idNumber;

    return data;
  }
}
