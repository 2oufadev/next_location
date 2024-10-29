import 'dart:typed_data';

class VideoModel {
  Uint8List? vidFile, imgFile;
  String? videoUrl, thumbnailUrl, bloblUrl;
  int? order;

  VideoModel(this.thumbnailUrl, this.videoUrl, this.vidFile, this.imgFile,
      this.bloblUrl, this.order);
  VideoModel.fromJson(Map<String, dynamic> json) {
    thumbnailUrl = json['thumbnailUrl'] ?? '';
    videoUrl = json['videoUrl'] ?? '';
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (thumbnailUrl != null) data['thumbnailUrl'] = thumbnailUrl;
    if (videoUrl != null) data['videoUrl'] = videoUrl;
    if (order != null) data['order'] = order;
    return data;
  }
}
