import 'package:json_annotation/json_annotation.dart';

part 'washroom_model.g.dart';

@JsonSerializable()
class WashroomModel {
  @JsonKey(name: 'geyser')
  bool? geyser;

  WashroomModel(
    this.geyser
  );

  Map<String, bool> washroomModelData() {
    var originalData = toJson();
    Map<String, bool> washroomModelData = originalData.map((key, value) {
      return MapEntry(key, value as bool);
    });
    return washroomModelData;
  }

  factory WashroomModel.fromJson(Map<String, dynamic> json) =>
      _$WashroomModelFromJson(json);

  Map<String, dynamic> toJson() => _$WashroomModelToJson(this);
}
