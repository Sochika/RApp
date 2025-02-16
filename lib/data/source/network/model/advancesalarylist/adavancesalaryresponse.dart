import '../advancesalarylist/Data.dart';

class AdavanceSalaryResponse {
  List<Data> data;
  String message;
  bool status;
  int status_code;

  AdavanceSalaryResponse(
      {required this.data,
      required this.message,
      required this.status,
      required this.status_code});

  factory AdavanceSalaryResponse.fromJson(Map<String, dynamic> json) {
    return AdavanceSalaryResponse(
      data: (json['data'] as List).map((i) => Data.fromJson(i)).toList(),
      message: json['message'],
      status: json['status'],
      status_code: json['status_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['status_code'] = status_code;
    data['data'] = this.data.map((v) => v.toJson()).toList();
      return data;
  }
}
