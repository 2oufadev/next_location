import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/users_api.dart';
import 'package:next_location/data/model/user_model.dart';

class UsersRepository {
  Future<UserModel?> getUserByID(String id) async {
    DocumentSnapshot? documentSnapshot = await UsersApi().getUserByID(id);

    UserModel? userModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  Future<UserModel?> getUserByNID(String nid) async {
    DocumentSnapshot? documentSnapshot = await UsersApi().getUserByNID(nid);

    UserModel? userModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  Future<UserModel?> getUserBySerial(String serial) async {
    DocumentSnapshot? documentSnapshot =
        await UsersApi().getUserBySerial(serial);

    UserModel? userModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  Future<dynamic> getUsersCount(String searchText, String searchFilter) async {
    return await UsersApi().getUsersCount(searchText, searchFilter);
  }

  Future<dynamic> getUsers(UserModel? lastModel, String filter,
      String ascDescSort, String searchText, String searchFilter) async {
    List<UserModel> usersList = [];
    QuerySnapshot? querySnapshot = await UsersApi()
        .getUsers(lastModel, filter, ascDescSort, searchText, searchFilter);
    if (querySnapshot != null) {
      if (querySnapshot.docs.isNotEmpty) {
        usersList = querySnapshot.docs
            .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      }

      return usersList;
    } else {
      return 'Timeout';
    }
  }

  Future<List<UserModel>> getPrevUsers(UserModel? firstModel, String filter,
      String ascDescSort, String searchText, String searchFilter) async {
    List<UserModel> userModelList = [];
    QuerySnapshot? querySnapshot = await UsersApi().getPrevUsers(
        firstModel, filter, ascDescSort, searchText, searchFilter);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      userModelList = querySnapshot.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    }
    return userModelList;
  }

  Future<bool> requestDeletion(UserModel userModel) async {
    var result = await UsersApi().requestDeletion(userModel);
    return result;
  }

  Future<bool> requestDeacativation(UserModel userModel) async {
    var result = await UsersApi().requestDeacativation(userModel);
    return result;
  }

  Future<bool> updateUserData(UserModel userModel, Uint8List? imgFile) async {
    var result = await UsersApi().updateUserData(userModel, imgFile);
    return result;
  }
}
