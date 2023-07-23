import 'package:json_annotation/json_annotation.dart';

part 'washroom_model.g.dart';

@JsonSerializable()
class WashroomModel {
  @JsonKey(name: 'geyser')
  bool? geyser;

  WashroomModel(this.geyser);

  factory WashroomModel.fromJson(Map<String, dynamic> json) =>
      _$WashroomModelFromJson(json);

  Map<String, dynamic> toJson() => _$WashroomModelToJson(this);
}
