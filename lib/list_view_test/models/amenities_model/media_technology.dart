class MediaTechnologyModel {
  bool? tv;
  bool? ott;

  MediaTechnologyModel(
    this.tv,
    this.ott,
  );

  MediaTechnologyModel.fromJson(Map<String, dynamic> json) {
    tv = json["tv"];
    ott = json["ott"];
  }
}
