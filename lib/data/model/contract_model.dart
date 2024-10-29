import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/model/contract_user_model.dart';

class ContractModel {
  String? contractId,
      sealingLocation,
      contractTitle,
      contractTerms,
      propertyId,
      ejariContractNumber;
  int? serial, status; // [ 0 = pending, 1 = approved, 2 = rejected]
  int? contractType; // 0 = residential, 1 = commercial
  Timestamp? createdDate, startDate, endDate;
  ContractUserModel? tenant, lessor;
  List<ContractUserModel>? signators;

  ContractModel(
      this.contractId,
      this.sealingLocation,
      this.status,
      this.contractTitle,
      this.contractType,
      this.contractTerms,
      this.propertyId,
      this.createdDate,
      this.startDate,
      this.endDate,
      this.tenant,
      this.lessor,
      this.signators,
      this.serial,
      this.ejariContractNumber);

  ContractModel.fromJson(Map<String, dynamic> json) {
    contractId = json['contractId'] ?? '';
    sealingLocation = json['sealingLocation'] ?? '';
    status = json['status'] ?? 0;
    contractTitle = json['contractTitle'] ?? '';
    contractType = json['contractType'] ?? 0;
    contractTerms = json['contractTerms'] ?? '';

    propertyId = json['propertyId'] ?? '';
    createdDate = json['createdDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    serial = json['serial'] ?? 0;
    ejariContractNumber = json['ejariContractNumber'] ?? '';
    if (json['tenant'] != null) {
      tenant =
          ContractUserModel.fromJson(json['tenant'] as Map<String, dynamic>);
    }
    if (json['lessor'] != null) {
      lessor =
          ContractUserModel.fromJson(json['lessor'] as Map<String, dynamic>);
    }

    if (json['signators'] != null) {
      List<dynamic> list = json['signators'];
      signators = list
          .map((e) => ContractUserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      signators = [];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (contractId != null) data['contractId'] = contractId;
    if (sealingLocation != null) data['sealingLocation'] = sealingLocation;
    if (status != null) data['status'] = status;
    if (contractTitle != null) data['contractTitle'] = contractTitle;
    if (contractType != null) data['contractType'] = contractType;
    if (contractTerms != null) data['contractTerms'] = contractTerms;

    if (propertyId != null) data['propertyId'] = propertyId;
    if (createdDate != null) data['createdDate'] = createdDate;
    if (startDate != null) data['startDate'] = startDate;
    if (endDate != null) data['endDate'] = endDate;
    if (serial != null) data['serial'] = serial;
    if (tenant != null) data['tenant'] = tenant!.toJson();
    if (lessor != null) data['lessor'] = lessor!.toJson();
    if (signators != null) {
      data['signators'] = signators!.map((e) => e.toJson()).toList();
    }
    if (ejariContractNumber != null) data['ejariContractNumber'];
    return data;
  }
}
