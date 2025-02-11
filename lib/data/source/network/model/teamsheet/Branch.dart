class ShiftOperative {
  final int beatBranchId;
  final String beatBranchName;
  final String area;
  final String latitude;
  final String longitude;
  final List<StaffAndShift> staffAndShifts;

  ShiftOperative({
    required this.beatBranchId,
    required this.beatBranchName,
    required this.area,
    required this.latitude,
    required this.longitude,
    required this.staffAndShifts,
  });


  factory ShiftOperative.fromJson(Map<String, dynamic> json) {
    return ShiftOperative(
      beatBranchId: json['beat_branch_id'],
      beatBranchName: json['beat_branch_name'],
      area: json['area'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      staffAndShifts: (json['staff_and_shifts'] as List)
          .map((item) => StaffAndShift.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beat_branch_id': beatBranchId,
      'beat_branch_name': beatBranchName,
      'area': area,
      'latitude': latitude,
      'longitude': longitude,
      'staff_and_shifts': staffAndShifts.map((item) => item.toJson()).toList(),
    };
  }
}

class StaffAndShift {
  final Staff staff;
  final ShiftType shiftType;
  final String startDate;
  final String shiftStart;
  final String shiftEnd;

  StaffAndShift({
    required this.staff,
    required this.shiftType,
    required this.startDate,
    required this.shiftStart,
    required this.shiftEnd,
  });

  factory StaffAndShift.fromJson(Map<String, dynamic> json) {
    return StaffAndShift(
      staff: Staff.fromJson(json['staff']),
      shiftType: ShiftType.fromJson(json['shift_type']),
      startDate: json['start_date'],
      shiftStart: json['shift_start'],
      shiftEnd: json['shift_end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'staff': staff.toJson(),
      'shift_type': shiftType.toJson(),
      'start_date': startDate,
      'shift_start': shiftStart,
      'shift_end': shiftEnd,
    };
  }
}

class Staff {
  final int id;
  final String name;
  final String phoneNumber;
  final String gender;
  final String avatar;

  Staff({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.avatar,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      gender: json['gender'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'gender': gender,
      'avatar': avatar,
    };
  }
}

class ShiftType {
  final int id;
  final String name;
  final int hours;

  ShiftType({
    required this.id,
    required this.name,
    required this.hours,
  });

  factory ShiftType.fromJson(Map<String, dynamic> json) {
    return ShiftType(
      id: json['id'],
      name: json['name'],
      hours: json['hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hours': hours,
    };
  }
}