import 'package:json_annotation/json_annotation.dart';

part 'hotel_contact_details.g.dart';

@JsonSerializable()
class HotelContactDetails {
  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'mailId')
  String mailId;

  HotelContactDetails({
    required this.phone,
    required this.mailId,
  });

  factory HotelContactDetails.fromJson(Map<String, dynamic> json) =>
      _$HotelContactDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$HotelContactDetailsToJson(this);
}
