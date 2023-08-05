import 'package:json_annotation/json_annotation.dart';

part 'safe_guidelines_model.g.dart';

@JsonSerializable()
class SafetyGuidelinesModel {
  @JsonKey(name: 'dos')
  List<String> dos;

  @JsonKey(name: 'donts')
  List<String> donts;

  SafetyGuidelinesModel({required this.dos, required this.donts});

  factory SafetyGuidelinesModel.fromJson(Map<String, dynamic> json) => _$SafetyGuidelinesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SafetyGuidelinesModelToJson(this);
}
