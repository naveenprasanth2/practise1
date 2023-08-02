import 'package:json_annotation/json_annotation.dart';

part 'seating_area_model.g.dart';

@JsonSerializable()
class SeatingAreaModel {
  @JsonKey(name: 'seatingArea')
  bool? seatingArea;

  Map<String, bool> seatingAreaModelData() {
    var originalData = toJson();
    Map<String, bool> seatingAreaModelData = originalData.map((key, value) {
      return MapEntry(key, value as bool);
    });
    return seatingAreaModelData;
  }

  SeatingAreaModel(this.seatingArea);

  factory SeatingAreaModel.fromJson(Map<String, dynamic> json) =>
      _$SeatingAreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatingAreaModelToJson(this);
}
