class LocationOperativeResponse {
  LocationOperativeResponse({
    required this.status,
    required this.message,
    required this.statusCode,
  });

  factory LocationOperativeResponse.fromJson(dynamic json) {
    return LocationOperativeResponse(
        status: json['status'],
        message: json['message'],
        statusCode: json['status_code']);
  }

  bool status;
  String message;
  int statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    return map;
  }
}
