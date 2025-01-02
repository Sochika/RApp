import 'BeatBranch.dart';

class UserAttend {
  final int id;
  final int staffId;
  final String shiftStart;
  final String shiftEnd;
  final int mainAssign;
  final BeatBranch beatBranch;
  final ShiftType shiftType;

  UserAttend({
    required this.id,
    required this.staffId,
    required this.shiftStart,
    required this.shiftEnd,
    required this.mainAssign,
    required this.beatBranch,
    required this.shiftType,
  });

  factory UserAttend.fromJson(Map<String, dynamic> json) {
    return UserAttend(
      id: json['id'],
      staffId: json['staff_id'],
      shiftStart: json['shift_start'],
      shiftEnd: json['shift_end'],
      mainAssign: json['main_assign'],
      beatBranch: BeatBranch.fromJson(json['beat_branch']),
      shiftType: ShiftType.fromJson(json['shift_type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'staff_id': staffId,
      'shift_start': shiftStart,
      'shift_end': shiftEnd,
      'main_assign': mainAssign,
      'beat_branch': beatBranch.toJson(),
      'shift_type': shiftType.toJson(),
    };
  }
}


