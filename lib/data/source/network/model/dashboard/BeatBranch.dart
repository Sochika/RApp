class BeatBranch {
  final int beatBranchId;
  final String name;
  final String area;
  final String latitude;
  final String longitude;

  BeatBranch({
    required this.beatBranchId,
    required this.name,
    required this.area,
    required this.latitude,
    required this.longitude,
  });

  factory BeatBranch.fromJson(Map<String, dynamic> json) {
    return BeatBranch(
      beatBranchId: json['beat_branch_id'],
      name: json['name'],
      area: json['area'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beat_branch_id': beatBranchId,
      'name': name,
      'area': area,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class ShiftType {
  final String name;
  final int hours;

  ShiftType({
    required this.name,
    required this.hours,
  });

  factory ShiftType.fromJson(Map<String, dynamic> json) {
    return ShiftType(
      name: json['name'] ?? '',
      hours: json['hours'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hours': hours,
    };
  }
}
