
import 'SettingsData.dart';

class SettingsResponse {
  SettingsResponse({
      required this.status,
      required this.message,
      required this.statusCode,
      required this.data,});

  factory SettingsResponse.fromJson(dynamic json) {
    return SettingsResponse(
      status : json['status'],
      message : json['message'],
      statusCode : json['status_code'],
      data : SettingsData.fromJson(json['data']),
    );
  }
  bool status;
  String message;
  int statusCode;
  SettingsData data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }

}