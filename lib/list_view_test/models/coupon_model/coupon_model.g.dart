// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => CouponModel(
      imageUrl: json['imageUrl'] as String,
      couponCode: json['couponCode'] as String,
      percentage: json['percentage'] as int,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String,
    );

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'couponCode': instance.couponCode,
      'percentage': instance.percentage,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
    };
