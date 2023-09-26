// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'mobileNo',
      'emailId',
      'dateOfBirth',
      'gender',
      'maritalStatus',
      'uid'
    ],
  );
  return UserProfileModel(
    name: json['name'] as String,
    mobileNo: json['mobileNo'] as String,
    emailId: json['emailId'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    gender: json['gender'] as String,
    maritalStatus: json['maritalStatus'] as String,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileNo': instance.mobileNo,
      'emailId': instance.emailId,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'maritalStatus': instance.maritalStatus,
      'uid': instance.uid,
    };
