import 'package:json_annotation/json_annotation.dart';

part 'seating_area_model.g.dart';

@JsonSerializable()
class SeatingAreaModel {
  @JsonKey(name: 'seatingArea')
  bool? seatingArea;

  SeatingAreaModel(this.seatingArea);

  factory SeatingAreaModel.fromJson(Map<String, dynamic> json) =>
      _$SeatingAreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatingAreaModelToJson(this);
}
