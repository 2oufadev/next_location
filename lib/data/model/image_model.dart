import 'dart:typed_data';

class ImageModel {
  Uint8List? imgFile;
  String? imgUrl;
  int? order;
  ImageModel(this.imgUrl, this.imgFile, this.order);
  ImageModel.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'] ?? '';
    order = json['order'] ?? 0;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (imgUrl != null) data['imgUrl'] = imgUrl;
    if (order != null) data['order'] = order;
    return data;
  }
}
