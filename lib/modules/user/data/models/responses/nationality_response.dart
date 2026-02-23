class NationalityResponse {
  int? status;
  String? message;
  List<Datum>? data;

  NationalityResponse({
    this.status,
    this.message,
    this.data,
  });

  factory NationalityResponse.fromJson(Map<String, dynamic> json) => NationalityResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? nation;
  String? nationality;
  String? nationCode;
  bool? status;
  String? language;
  String? langCode;
  String? description;
  DateTime? createdAt;
  dynamic deletedAt;

  Datum({
    this.id,
    this.nation,
    this.nationality,
    this.nationCode,
    this.status,
    this.language,
    this.langCode,
    this.description,
    this.createdAt,
    this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    nation: json["nation"],
    nationality: json["nationality"],
    nationCode: json["nationCode"],
    status: json["status"],
    language: json["language"],
    langCode: json["langCode"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nation": nation,
    "nationality": nationality,
    "nationCode": nationCode,
    "status": status,
    "language": language,
    "langCode": langCode,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
