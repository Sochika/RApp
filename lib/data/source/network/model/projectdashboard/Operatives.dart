// project_dashboard_response.dart
import 'package:radius/data/source/network/model/dashboard/BeatBranch.dart';

class OperativesDashboardResponse {
  final bool status;
  final String message;
  final int statusCode;
  final DashboardData data;

  OperativesDashboardResponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory OperativesDashboardResponse.fromJson(Map<String, dynamic> json) => OperativesDashboardResponse(
    status: json['status'],
    message: json['message'],
    statusCode: json['status_code'],
    data: DashboardData.fromJson(json['data']),
  );
}

class DashboardData {
  final List<OperativeShift> operatives;
  final Map<int, int> onDuties;

  DashboardData({
    required this.operatives,
    required this.onDuties,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    operatives: List<OperativeShift>.from(
        json['operatives'].map((x) => OperativeShift.fromJson(x))),
    onDuties: Map.from(json['onDuties'])
        .map((k, v) => MapEntry(int.parse(k), v as int)),
  );
}

// Operative classes (same as previous response)
class OperativeShift {
  final int beatId;
  final int beatBranchId;
  final String startDate;
  final String shiftStart;
  final String shiftEnd;
  final int shiftTypeId;
  final int mainAssign;
  final int shiftOn;
  final String shiftDateStart;
  final dynamic expires;
  final dynamic comment;
  final dynamic rate;
  final Operative operative;
  final ShiftType shiftType;

  OperativeShift({
    required this.beatId,
    required this.beatBranchId,
    required this.startDate,
    required this.shiftStart,
    required this.shiftEnd,
    required this.shiftTypeId,
    required this.mainAssign,
    required this.shiftOn,
    required this.shiftDateStart,
    this.expires,
    this.comment,
    this.rate,
    required this.operative,
    required this.shiftType,
  });

  factory OperativeShift.fromJson(Map<String, dynamic> json) => OperativeShift(
    beatId: json['beat_id'],
    beatBranchId: json['beat_branch_id'],
    startDate: json['start_date'],
    shiftStart: json['shift_start'],
    shiftEnd: json['shift_end'],
    shiftTypeId: json['shift_type_id'],
    mainAssign: json['main_assign'],
    shiftOn: json['shift_on'],
    shiftDateStart: json['shift_date_start'],
    expires: json['expires'] ?? '',
    comment: json['comment'] ?? '',
    rate: json['rate'] ?? '',
    operative: Operative.fromJson(json['operative']),
    shiftType: ShiftType.fromJson(json['shiftType']),
  );
}

class Operative {
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;
  final String gender;
  final String phoneNumber;

  Operative({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.gender,
    required this.phoneNumber,
  });

  factory Operative.fromJson(Map<String, dynamic> json) => Operative(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    avatar: json['avatar'] ?? '',
    gender: json['gender'],
    phoneNumber: json['phone_number'] ?? '',
  );
}