// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safe_guidelines_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SafetyGuidelinesModel _$SafetyGuidelinesModelFromJson(
        Map<String, dynamic> json) =>
    SafetyGuidelinesModel(
      dos: (json['dos'] as List<dynamic>).map((e) => e as String).toList(),
      donts: (json['donts'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SafetyGuidelinesModelToJson(
        SafetyGuidelinesModel instance) =>
    <String, dynamic>{
      'dos': instance.dos,
      'donts': instance.donts,
    };
