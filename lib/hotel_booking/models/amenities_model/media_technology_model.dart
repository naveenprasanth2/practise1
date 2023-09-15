import 'package:json_annotation/json_annotation.dart';

part 'media_technology_model.g.dart';

@JsonSerializable()
class MediaTechnologyModel {
  @JsonKey(name: 'tv')
  bool? tv;

  @JsonKey(name: 'ott')
  bool? ott;

  MediaTechnologyModel({
    this.tv,
    this.ott
  });

  Map<String, bool> mediaTechnologyModelData() {
    var originalData = toJson();
    Map<String, bool> mediaTechnologyModelData = originalData.map((key, value) {
      return MapEntry(key, value as bool);
    });
    return mediaTechnologyModelData;
  }


  factory MediaTechnologyModel.fromJson(Map<String, dynamic> json) =>
      _$MediaTechnologyModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaTechnologyModelToJson(this);
}
