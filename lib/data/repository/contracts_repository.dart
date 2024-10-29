import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/contracts_api.dart';
import 'package:next_location/data/model/contract_model.dart';
import 'package:next_location/data/model/contract_user_model.dart';

class ContractsRepository {
  Future<ContractModel?> getContractById(String id) async {
    ContractModel? contractModel;
    DocumentSnapshot? documentSnapshot =
        await ContractsApi().getContractById(id);
    if (documentSnapshot != null && documentSnapshot.exists) {
      contractModel = ContractModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }
    return contractModel;
  }

  Future<ContractModel?> getContractBySerial(
      int serial, bool approvedOnly) async {
    ContractModel? contractModel;
    DocumentSnapshot? documentSnapshot =
        await ContractsApi().getContractBySerial(serial, approvedOnly);
    if (documentSnapshot != null && documentSnapshot.exists) {
      contractModel = ContractModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }
    return contractModel;
  }

  Future<int> getTenantsContractsCount(String userId, bool approvedOnly) async {
    return await ContractsApi().getTenantsContractsCount(userId, approvedOnly);
  }

  Future<int> getLessorsContractsCount(String userId, bool approvedOnly) async {
    return await ContractsApi().getLessorsContractsCount(userId, approvedOnly);
  }

  Future<List<ContractModel>> getTenantsContracts(
      String userId, bool approvedOnly) async {
    QuerySnapshot? snapshot =
        await ContractsApi().getTenantsContracts(userId, approvedOnly);
    List<ContractModel> contractsList = [];

    if (snapshot != null && snapshot.docs.isNotEmpty) {
      contractsList = snapshot.docs
          .map(
            (e) => ContractModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return contractsList;
  }

  Future<List<ContractModel>> getLessorsContracts(
      String userId, bool approvedOnly) async {
    QuerySnapshot? snapshot =
        await ContractsApi().getLessorsContracts(userId, approvedOnly);
    List<ContractModel> contractsList = [];

    if (snapshot != null && snapshot.docs.isNotEmpty) {
      contractsList = snapshot.docs
          .map(
            (e) => ContractModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }

    return contractsList;
  }

  Future<dynamic> acceptContract(
      String contractId, ContractUserModel userData) async {
    return await ContractsApi().acceptContract(contractId, userData);
  }
}
