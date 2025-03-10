import '../projectdashboard/OnDuties.dart';
import 'User.dart';
import 'Shift.dart';
import 'UserAttend.dart';

class Dashboard {
  final User user;
  final List<Shift> shifts; // Corrected to handle a list of shifts
  final UserAttend userAttend;
  final Map<String, int> onDuties;
  final Graduated graduated;

  Dashboard( {
    required this.user,
    required this.shifts,
    required this.userAttend,
    required this.onDuties,
    required this.graduated,
  });

  /// Deserialization method
  factory Dashboard.fromJson(Map<String, dynamic> json) {
    try {
      return Dashboard(
        user: User.fromJson(json['user'] ?? {}),
        shifts: (json['shift'] as List<dynamic>? ?? []) // ✅ Fixed key
            .map((shiftJson) => Shift.fromJson(shiftJson))
            .toList(),
        userAttend: UserAttend.fromJson(json['userAttend'] ?? {}),
        onDuties: Map<String, int>.from(json['onDuties']),
        graduated: Graduated.fromJson(json['graduated'] ),
      );
    } catch (e) {
      throw Exception('Failed to parse Dashboard: $e');
    }
  }

  /// Serialization method
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'shift': shifts.map((shift) => shift.toJson()).toList(),
      'userAttend': userAttend.toJson(),
      // 'onDuties': onDuties.toJson(),
      'graduated': graduated.toJson(),
    };
  }
}
