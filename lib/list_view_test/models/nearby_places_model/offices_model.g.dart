// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offices_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficesModel _$OfficesModelFromJson(Map<String, dynamic> json) => OfficesModel(
      (json['offices'] as List<dynamic>)
          .map((e) => OfficeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfficesModelToJson(OfficesModel instance) =>
    <String, dynamic>{
      'offices': instance.offices,
    };
