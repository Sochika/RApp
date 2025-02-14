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

/// Represents a graduation status entity
class Graduated {
  final int graduated;

  /// Creates a [Graduated] instance
  ///
  /// [graduated] must be either 0 (not graduated) or 1 (graduated)
  Graduated({
    required this.graduated,
  }) : assert(graduated == 0 || graduated == 1,
  'Graduated value must be 0 or 1');

  /// Creates a [Graduated] instance from JSON data
  ///
  /// Handles potential missing values by defaulting to 0
  // factory Graduated.fromJson(Map<String, dynamic> json) {
  //   return Graduated(
  //     graduated: (json['graduated'] is int) ? json['graduated'] : 0,
  //   );
  // }
  factory Graduated.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw Exception("Failed to parse Graduated: Expected a JSON object but got ${json.runtimeType}");
    }

    return Graduated(
      graduated: (json['graduated'] is int) ? json['graduated'] : 0,
    );
  }



  /// Converts to JSON format
  Map<String, dynamic> toJson() {
    return {
      'graduated': graduated,
    };
  }
}
