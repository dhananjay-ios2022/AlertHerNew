class EditReviewRequest {
  String? id;
  int? flag;
  String? description;
 // String? clientName;

  EditReviewRequest({
    this.id,
    this.flag,
    this.description,
   // this.clientName,
  });

  factory EditReviewRequest.fromJson(Map<String, dynamic> json) => EditReviewRequest(
    id: json["_id"],
    flag: json["flag"],
    description: json["description"],
  //  clientName: json["clientName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "flag": flag,
    "description": description,
  //  "clientName": clientName,
  };
}
