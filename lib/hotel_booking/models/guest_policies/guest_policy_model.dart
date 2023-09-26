import 'package:json_annotation/json_annotation.dart';

part 'guest_policy_model.g.dart';

@JsonSerializable()
class GuestPolicyModel {
  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  GuestPolicyModel({
    required this.title,
    required this.description,
  });

  factory GuestPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$GuestPolicyModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuestPolicyModelToJson(this);
}
