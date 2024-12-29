class Data {
  String remark;
  String requested_date;
  String released_date;
  String description;
  int id;
  bool is_settled;
  String released_amount;
  String requested_amount;
  String status;
  String verified_by;
  Data(
      {required this.remark,
      required this.requested_date,
      required this.released_date,
      required this.description,
      required this.id,
      required this.is_settled,
      required this.released_amount,
      required this.requested_amount,
      required this.status,
      required this.verified_by});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      remark: json['remark'].toString(),
      requested_date: json['requested_date'].toString(),
      released_date: json['released_date'].toString(),
      description: json['description'].toString(),
      id: json['id'],
      is_settled: json['is_settled'],
      released_amount: json['released_amount'].toString(),
      requested_amount: json['requested_amount'].toString(),
      status: json['status'].toString(),
      verified_by: json['verified_by'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remark'] = remark;
    data['requested_date'] = released_date;
    data['released_date'] = released_date;
    data['description'] = description;
    data['id'] = id;
    data['is_settled'] = is_settled;
    data['released_amount'] = released_amount;
    data['requested_amount'] = requested_amount;
    data['status'] = status;
    return data;
  }
}
