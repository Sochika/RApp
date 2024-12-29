class Data {
  String employee;
  int id;
  String remark;
  String status;
  String submitted_date;
  String title;
  String total_expense;

  Data(
      {required this.employee,
      required this.id,
      required this.remark,
      required this.status,
      required this.submitted_date,
      required this.title,
      required this.total_expense});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      employee: json['employee'].toString(),
      id: json['id'],
      remark: json['remark'].toString(),
      status: json['status'].toString(),
      submitted_date: json['submitted_date'].toString(),
      title: json['title'].toString(),
      total_expense: json['total_expense'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee'] = employee;
    data['id'] = id;
    data['remark'] = remark;
    data['status'] = status;
    data['submitted_date'] = submitted_date;
    data['title'] = title;
    data['total_expense'] = total_expense;
    return data;
  }
}
