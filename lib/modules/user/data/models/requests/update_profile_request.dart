class UpdateProfileRequest {
  String? gender;
  String? nationality;
  String? preferredLang;

  UpdateProfileRequest({
    this.gender,
    this.nationality,
    this.preferredLang,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) => UpdateProfileRequest(
    gender: json["gender"],
    nationality: json["nationality"],
    preferredLang: json["preferredLang"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "nationality": nationality,
    "preferredLang": preferredLang,
  };
}
