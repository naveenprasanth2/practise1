import 'package:json_annotation/json_annotation.dart';

part 'hotel_images_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HotelImagesModel {
  @JsonKey(name: 'room')
  List<String> room;

  @JsonKey(name: 'others')
  List<String> others;

  @JsonKey(name: 'washroom')
  List<String> washroom;

  @JsonKey(name: 'lobby')
  List<String> lobby;

  @JsonKey(name: 'reception')
  List<String> reception;

  @JsonKey(name: 'facade')
  List<String> facade;

  HotelImagesModel({
    required this.room,
    required this.others,
    required this.washroom,
    required this.lobby,
    required this.reception,
    required this.facade,
  });

  // Getter to combine all images into a single list
  List<String> get allImages {
    return [...room, ...others, ...washroom, ...lobby, ...reception, ...facade];
  }

  List<String> getImageFromType(String type) {
    switch (type) {
      case "room":
        return room;
      case "others":
        return others;
      case "washroom":
        return washroom;
      case "lobby":
        return lobby;
      case "reception":
        return reception;
      case "facade":
        return facade;
      default:
        return allImages;
    }
  }

  factory HotelImagesModel.fromJson(Map<String, dynamic> json) =>
      _$HotelImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelImagesModelToJson(this);
}
