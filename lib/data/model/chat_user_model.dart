class ChatUserModel {
  String? userId, imgUrl, userName;
  ChatUserModel(this.userId, this.imgUrl, this.userName);

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? '';
    imgUrl = json['imgUrl'] ?? '';
    userName = json['userName'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (userId != null) data['userId'] = userId;
    if (imgUrl != null) data['imgUrl'] = imgUrl;
    if (userName != null) data['userName'] = userName;
    return data;
  }
}
