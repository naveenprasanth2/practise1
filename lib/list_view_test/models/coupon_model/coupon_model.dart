import 'package:json_annotation/json_annotation.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class CouponModel {
  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  @JsonKey(name: 'couponCode')
  final String couponCode;

  @JsonKey(name: 'percentage')
  final int percentage;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'shortDescription')
  final String shortDescription;

  CouponModel({
    required this.imageUrl,
    required this.couponCode,
    required this.percentage,
    required this.description,
    required this.shortDescription,
  });

  // This factory method is used to create the model from a JSON map.
  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  // This method is used to convert the model to a JSON map.
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
