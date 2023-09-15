// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedTypeModel _$BedTypeModelFromJson(Map<String, dynamic> json) => BedTypeModel(
      json['cot'] as bool?,
      json['kingSizedBed'] as bool?,
      json['queenSizedBed'] as bool?,
      json['singleBed'] as bool?,
    );

Map<String, dynamic> _$BedTypeModelToJson(BedTypeModel instance) =>
    <String, dynamic>{
      'cot': instance.cot,
      'kingSizedBed': instance.kingSizedBed,
      'queenSizedBed': instance.queenSizedBed,
      'singleBed': instance.singleBed,
    };
