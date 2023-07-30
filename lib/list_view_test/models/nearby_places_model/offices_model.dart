import 'package:json_annotation/json_annotation.dart';
import 'package:practise1/list_view_test/models/nearby_places_model/office_model.dart';

part 'offices_model.g.dart';

@JsonSerializable()
class OfficesModel {
  @JsonKey(name: 'offices')
  final List<OfficeModel> offices;

  OfficesModel(this.offices);

  factory OfficesModel.fromJson(Map<String, dynamic> json) => _$OfficesModelFromJson(json);
  Map<String, dynamic> toJson() => _$OfficesModelToJson(this);
}
