
class AdavanceSalaryCreateResponse {
  String message;
  bool status;
  int status_code;

  AdavanceSalaryCreateResponse(
      {
      required this.message,
      required this.status,
      required this.status_code});

  factory AdavanceSalaryCreateResponse.fromJson(Map<String, dynamic> json) {
    return AdavanceSalaryCreateResponse(
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
    return data;
  }
}
