import 'package:radius/data/source/network/model/dashboard/Feature.dart';
import 'package:radius/data/source/network/model/dashboard/RecentAward.dart';
import 'package:radius/data/source/network/model/hollidays/Holidays.dart';
import 'package:radius/data/source/network/model/teamsheet/Employee.dart';
import 'package:radius/model/award.dart';

import 'User.dart';
import 'EmployeeTodayAttendance.dart';
import 'Overview.dart';
import 'OfficeTime.dart';
import 'Company.dart';

class Dashboard {
  Dashboard({
    required this.user,
    required this.employeeTodayAttendance,
    required this.overview,
    required this.officeTime,
    required this.company,
    required this.employeeWeeklyReport,
    required this.shift_dates,
    required this.dateInAd,
    required this.addNfc,
    required this.attendance_note,
    required this.employee,
    required this.features,
    required this.holiday,
    required this.recentAward,
  });

  factory Dashboard.fromJson(dynamic json) {
    print(json["recent_award"]);
    return Dashboard(
      user: User.fromJson(json['user']),
      employeeTodayAttendance:
          EmployeeTodayAttendance.fromJson(json['employee_today_attendance']),
      overview: Overview.fromJson(json['overview']),
      officeTime: OfficeTime.fromJson(json['office_time']),
      company: Company.fromJson(json['company']),
      employeeWeeklyReport: json['employee_weekly_report'],
      shift_dates: List.from(json['shift_dates']),
      dateInAd: json['date_in_ad'],
      addNfc: json['add_nfc'] ?? true,
      attendance_note: json['attendance_note'] ?? false,
      employee: json["teamMembers"] != null
          ? List<Employee>.from(
              json['teamMembers'].map((x) => Employee.fromJson(x)))
          : [],
      features:
          (json['features'] as List).map((i) => Feature.fromJson(i)).toList(),
      holiday: json["recent_holiday"] != null
          ? Holidays.fromJson(json["recent_holiday"])
          : null,
      recentAward: json["recent_award"] != null
          ? RecentAward.fromJson(json['recent_award'])
          : null,
    );
  }

  User user;
  List<Feature> features;
  EmployeeTodayAttendance employeeTodayAttendance;
  Overview overview;
  OfficeTime officeTime;
  Company company;
  List<dynamic> employeeWeeklyReport;
  List<String> shift_dates;
  bool dateInAd;
  bool addNfc;
  bool attendance_note;
  List<Employee> employee;
  Holidays? holiday;
  RecentAward? recentAward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user.toJson();
    map['employee_today_attendance'] = employeeTodayAttendance.toJson();
    map['overview'] = overview.toJson();
    map['office_time'] = officeTime.toJson();
    map['company'] = company.toJson();
    map['employee_weekly_report'] =
        employeeWeeklyReport.map((v) => v.toJson()).toList();
    return map;
  }
}
