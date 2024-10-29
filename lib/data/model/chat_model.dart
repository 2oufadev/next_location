import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/model/chat_user_model.dart';
import 'package:next_location/data/model/message_model.dart';

class ChatModel {
  String? chatId, initiatedBy;

  Timestamp? createdDate;
  List<String>? usersIds;
  List<int>? newMessages;
  List<ChatUserModel>? usersData;

  MessageModel? lastMessage;

  ChatModel(
    this.chatId,
    this.initiatedBy,
    this.usersIds,
    this.lastMessage,
    this.usersData,
    this.createdDate,
    this.newMessages,
  );

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'] ?? '';
    initiatedBy = json['initiatedBy'] ?? '';
    if (json['usersIds'] != null) {
      List list = json['usersIds'];
      usersIds = list
          .map(
            (e) => e.toString(),
          )
          .toList();
    } else {
      usersIds = [];
    }

    if (json['usersData'] != null) {
      List list = json['usersData'];
      usersData = list
          .map(
            (e) => ChatUserModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } else {
      usersData = [];
    }
    createdDate = json['createdDate'];

    if (json['newMessages'] != null) {
      List list = json['newMessages'];
      newMessages = list
          .map(
            (e) => e as int,
          )
          .toList();
    } else {
      newMessages = [];
    }
    if (json['lastMessage'] != null) {
      lastMessage =
          MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>);
    } else {
      lastMessage = null;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (chatId != null) data['chatId'] = chatId;
    if (initiatedBy != null) data['initiatedBy'] = initiatedBy;
    if (usersIds != null) data['usersIds'] = usersIds;
    if (usersData != null) {
      data['usersData'] = usersData!.map(
        (e) => e.toJson(),
      );
    }

    if (createdDate != null) data['createdDate'] = createdDate;
    if (newMessages != null) data['newMessages'] = newMessages;

    if (lastMessage != null) data['lastMessage'] = lastMessage!.toJson();

    return data;
  }
}
