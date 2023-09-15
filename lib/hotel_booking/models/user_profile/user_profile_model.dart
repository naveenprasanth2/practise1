import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  @JsonKey(required: true)
  late String name;

  @JsonKey(required: true)
  late String mobileNo;

  @JsonKey(required: true)
  late String emailId;

  @JsonKey(required: true)
  late String dateOfBirth;

  @JsonKey(required: true)
  late String gender;

  @JsonKey(required: true)
  late String maritalStatus;

  @JsonKey(required: true)
  late String uid;

  UserProfileModel({
    required this.name,
    required this.mobileNo,
    required this.emailId,
    required this.dateOfBirth,
    required this.gender,
    required this.maritalStatus,
    required this.uid
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
