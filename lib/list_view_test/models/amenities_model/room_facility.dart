class RoomFacilityModel {
  bool? extraMattress;
  bool? smokeDetector;
  bool? interCom;
  bool? books;

  RoomFacilityModel(
    this.extraMattress,
    this.smokeDetector,
    this.interCom,
    this.books,
  );

  RoomFacilityModel.fromJson(Map<String, dynamic> json) {
    extraMattress = json["extraMattress"];
    smokeDetector = json["smokeDetector"];
    interCom = json["interCom"];
    books = json["books"];
  }
}
