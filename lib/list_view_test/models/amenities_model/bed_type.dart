class BedTypeModel {
  bool? cot;
  bool? kingSizedBed;
  bool? queenSizedBed;
  bool? singleBed;

  BedTypeModel(
    this.cot,
    this.kingSizedBed,
    this.queenSizedBed,
    this.singleBed,
  );

  BedTypeModel.fromJson(Map<dynamic, dynamic> json){
    cot = json["cot"];
    kingSizedBed = json["kingSizedBed"];
    queenSizedBed = json["queenSizedBed"];
    singleBed = json["singleBed"];
  }
}
