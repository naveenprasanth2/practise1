class SeatingAreaModel {
  bool? seatingArea;

  SeatingAreaModel(this.seatingArea);

  SeatingAreaModel.fromJson(Map<String, dynamic> json) {
    seatingArea = json["seatingArea"];
  }
}
