import 'dart:ffi';

class Shift {
  Shift({
    required this.shiftStart,
    required this.shiftEnd,
    required this.mainAssign,
    required this.beatBranch,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      shiftStart: json['shift_start'] ?? '',
      shiftEnd: json['shift_end'] ?? '',
      mainAssign: json['main_assign'] ?? 0,
      beatBranch: BeatBranch.fromJson(json['beat_branch'] ?? {}),
    );
  }

  final String shiftStart;
  final String shiftEnd;
  final int mainAssign;
  final BeatBranch beatBranch;

  Map<String, dynamic> toJson() {
    return {
      'shift_start': shiftStart,
      'shift_end': shiftEnd,
      'main_assign': mainAssign,
      'beat_branch': beatBranch.toJson(),
    };
  }
}

class BeatBranch {
  BeatBranch({
    required this.beat_branch_id,
    required this.name,
    required this.area,
    required this.latitude,
    required this.longitude,
  });

  factory BeatBranch.fromJson(Map<String, dynamic> json) {
    return BeatBranch(
      beat_branch_id: json['beat_branch_id'] ?? '',
      name: json['name'] ?? '',
      area: json['area'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  final Int beat_branch_id;
  final String name;
  final String area;
  final String latitude;
  final String longitude;

  Map<String, dynamic> toJson() {
    return {
      'beat_branch_id' : beat_branch_id,
      'name': name,
      'area': area,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class ShiftList {
  ShiftList({required this.shifts});

  factory ShiftList.fromJson(List<dynamic> jsonList) {
    return ShiftList(
      shifts: jsonList.map((json) => Shift.fromJson(json)).toList(),
    );
  }

  final List<Shift> shifts;

  List<Map<String, dynamic>> toJson() {
    return shifts.map((shift) => shift.toJson()).toList();
  }
}
