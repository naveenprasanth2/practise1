class HotelFacilitiesModel {
  bool? ac;
  bool? wifi;
  bool? kitchen;
  bool? restaurant;
  bool? reception;
  bool? careTaker;
  bool? security;
  bool? shuttleService;
  bool? luggageAssistance;
  bool? taxi;
  bool? dailyHousekeeping;
  bool? fireExtinguisher;
  bool? firstAidKit;

  HotelFacilitiesModel(
    this.ac,
    this.wifi,
    this.kitchen,
    this.restaurant,
    this.reception,
    this.careTaker,
    this.security,
    this.shuttleService,
    this.luggageAssistance,
    this.taxi,
    this.dailyHousekeeping,
    this.fireExtinguisher,
    this.firstAidKit,
  );

  HotelFacilitiesModel.fromJson(Map<String, dynamic> json) {
    ac = json["ac"];
    wifi = json["wifi"];
    kitchen = json["kitchen"];
    restaurant = json["restaurant"];
    reception = json["reception"];
    careTaker = json["careTaker"];
    security = json["security"];
    shuttleService = json["shuttleService"];
    luggageAssistance = json["luggageAssistance"];
    taxi = json["taxi"];
    dailyHousekeeping = json["dailyHousekeeping"];
    fireExtinguisher = json["fireExtinguisher"];
    firstAidKit = json["firstAidKit"];
  }
}
