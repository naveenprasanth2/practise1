import 'package:json_annotation/json_annotation.dart';

part 'bed_type_model.g.dart';

@JsonSerializable()
class BedTypeModel {
  @JsonKey(name: 'cot')
  bool? cot;

  @JsonKey(name: 'kingSizedBed')
  bool? kingSizedBed;

  @JsonKey(name: 'queenSizedBed')
  bool? queenSizedBed;

  @JsonKey(name: 'singleBed')
  bool? singleBed;

  BedTypeModel(
      this.cot,
      this.kingSizedBed,
      this.queenSizedBed,
      this.singleBed,
      );

  factory BedTypeModel.fromJson(Map<String, dynamic> json) =>
      _$BedTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedTypeModelToJson(this);
}
