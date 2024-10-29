import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/users_api.dart';
import 'package:next_location/data/model/user_model.dart';

class UsersRepository {
  Future<dynamic> addUser(UserModel model, Uint8List? imgFile) async {
    return await UsersApi().addUser(model, imgFile);
  }

  Future<UserModel?> getUserByID(String id) async {
    DocumentSnapshot? documentSnapshot = await UsersApi().getUserByID(id);

    UserModel? userModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  Future<UserModel?> getUserByNID(String nid, bool approvedOnly) async {
    DocumentSnapshot? documentSnapshot =
        await UsersApi().getUserByNID(nid, approvedOnly);

    UserModel? userModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  Future<UserModel?> getUserBySerial(int serial, bool approvedOnly) async {
    DocumentSnapshot? documentSnapshot =
        await UsersApi().getUserBySerial(serial, approvedOnly);

    UserModel? userModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  Future<dynamic> getUsersCount(
      String searchText, int role, String searchFilter) async {
    return await UsersApi().getUsersCount(searchText, role, searchFilter);
  }

  // role options [0 = end users, 1 = agent, 2 = owner, 3 = real estate managers]
  // sort options [ 'createdDate', 'dateOfBirth', 'email', 'lastActiveDate', 'nid', 'online', 'phone', 'role', 'serial', 'userName']
  // search filters options [ 'userName', 'phone', 'nid', 'email', 'serial']
  Future<dynamic> getUsers(UserModel? lastModel, int role, String sort,
      bool descending, String searchText, String searchFilter) async {
    List<UserModel> usersList = [];
    QuerySnapshot? querySnapshot = await UsersApi()
        .getUsers(lastModel, role, sort, descending, searchText, searchFilter);
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
