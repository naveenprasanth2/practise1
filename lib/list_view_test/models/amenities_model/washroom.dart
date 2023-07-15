class WashroomModel {
  bool? geyser;

  WashroomModel(this.geyser);

  WashroomModel.fromJson(Map<String, dynamic> json) {
    geyser = json["geyser"];
  }
}
