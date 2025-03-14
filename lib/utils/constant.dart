import 'package:radius/model/month.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class Constant {
  static const production = "https://radius.mandroid.ng/";
  static const keonUrl = "https://radius.suchtree.com/";
  static const staging = "https://attendance.suchtree.com/";
  static const localhost = "http://192.168.0.134:8004/";
  static const suchphn = "http://192.168.95.2:8004/";

  static const appUrl = suchphn;

  // /**
  //  * Change value based on your need.
  //  */
  static const MAIN_URL = appUrl;

  static const API_URL = "api";
  static const IMAGE_URL = "${MAIN_URL}images/";
  static const MALE_IMAGE_URL = "${MAIN_URL}assets/img/avatars/male.png";
  static const FEMALE_IMAGE_URL = "${MAIN_URL}assets/img/avatars/female.png";
  static const PRIVACY_POLICY_URL = "${MAIN_URL}privacy";

  static const LOGIN_URL = "$API_URL/login";
  static const LOGOUT_URL = "$API_URL/logout";
  static const DASHBOARD_URL = "$API_URL/dashboard";
  static const OVERVIEW_URL = "$API_URL/overview";

  static const LOCATIONOPERATIVE_URL = "$API_URL/locationOperative";

  static const CHECK_IN_URL = "$API_URL/staff/check-in";
  static const CHECK_OUT_URL = "$API_URL/employees/check-out";
  static const ATTENDANCE_URL = "$API_URL/staff/attendance";

  static const ADD_NFC_URL = "$API_URL/nfc/store";

  static const SETTINGS_URL = "$API_URL/settings";

  static const SEND_PUSH_NOTIFICATION = "$API_URL/employee/push";

  static const ATTENDANCE_REPORT_URL = "$API_URL/employees/attendance-detail";
  static const LEAVE_TYPE_URL = "$API_URL/leave-types";
  static const LEAVE_TYPE_DETAIL_URL =
      "$API_URL/leave-requests/employee-leave-requests";
  static const ISSUE_LEAVE = "$API_URL/leave-requests/store";
  static const ISSUE_TIME_LEAVE = "$API_URL/time-leave-requests/store";
  static const CANCEL_LEAVE = "$API_URL/leave-requests/cancel";
  static const CANCEL_TIME_LEAVE = "$API_URL/time-leave-requests/cancel";
  static const PROFILE_URL = "$API_URL/users/profile";
  static const EMPLOYEE_PROFILE_URL = "$API_URL/users/profile-detail";
  static const CONTENT_URL = "$API_URL/static-page-content";
  static const TEAM_SHEET_URL = "$API_URL/radius/team-sheet";
  static const LEAVE_CALENDAR_API =
      "$API_URL/leave-requests/employee-leave-calendar";
  static const LEAVE_CALENDAR_BY_DAY_API =
      "$API_URL/leave-requests/employee-leave-list";
  static const OFFICE_CALENDAR_API =
      "$API_URL/employee/office-calendar";
  static const HOLIDAYS_API = "$API_URL/holidays";
  static const CHANGE_PASSWORD_API = "$API_URL/users/change-password";
  static const RULES_API = "$API_URL/company-rules";
  static const EDIT_PROFILE_URL = "$API_URL/users/update-profile";
  static const NOTIFICATION_URL = "$API_URL/notifications";
  static const NOTICE_URL = "$API_URL/notices";
  static const MEETING_URL = "$API_URL/team-meetings";

  static const BEAT_DETAILS_URL = "$API_URL/beatDetail";
  static const PROJECT_DASHBOARD_URL = "$API_URL/project-management-dashboard";
  static const PROJECT_LIST_URL = "$API_URL/assigned-projects-list";
  static const PROJECT_DETAIL_URL = "$API_URL/assigned-projects-detail";
  static const TASK_LIST_URL = "$API_URL/assigned-task-list";
  static const TASK_DETAIL_URL = "$API_URL/assigned-task-detail";
  static const UPDATE_CHECKLIST_TOGGLE_URL =
      "$API_URL/assigned-task-checklist/toggle-status";
  static const UPDATE_TASK_TOGGLE_URL =
      "$API_URL/assigned-task-detail/change-status";
  static const EMPLOYEE_DETAIL_URL = "$API_URL/users/profile-detail";
  static const GET_COMMENT_URL = "$API_URL/assigned-task-comments";
  static const SAVE_COMMENT_URL = "$API_URL/assigned-task/comments/store";
  static const DELETE_COMMENT_URL = "$API_URL/assigned-task/comment/delete";
  static const DELETE_REPLY_URL = "$API_URL/assigned-task/reply/delete";

  static const TADA_LIST_URL = "$API_URL/employee/tada-lists";
  static const TADA_DETAIL_URL = "$API_URL/employee/tada-details";
  static const TADA_STORE_URL = "$API_URL/employee/tada/store";
  static const TADA_UPDATE_URL = "$API_URL/employee/tada/update";
  static const TADA_DELETE_ATTACHMENT_URL =
      "$API_URL/employee/tada/delete-attachment";

  static const ADVANCE_SALARY_LIST_URL =
      "$API_URL/employee/advance-salaries-lists";
  static const ADVANCE_SALARY_CREATE_URL =
      "$API_URL/employee/advance-salaries/store";
  static const ADVANCE_SALARY_UPDATE_URL =
      "$API_URL/employee/advance-salaries-detail/update";
  static const ADVANCE_SALARY_DETAIL_URL =
      "$API_URL/employee/advance-salaries-detail";

  static const SUPPORT_URL = "$API_URL/support/query-store";
  static const DEPARTMENT_LIST_URL = "$API_URL/support/department-lists";
  static const SUPPORT_LIST_URL = "$API_URL/support/get-user-query-lists";

  static const PAYSLIP_LIST_URL = "$API_URL/employee/payslip";
  static const PAYSLIP_DETAIL_URL = "$API_URL/employee/payslip/";

  static const AWARDS_URL = "$API_URL/awards/";

  static const TOTAL_WORKING_HOUR = 8;
}

extension StringExtension on String {
  bool isUnique() {
    return true;
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 12);
}

String unknownError(e) {
  try {
    if (e is String) {
      throw e.toString();
    } else {
      var errorMessage = e['message'];
      throw errorMessage;
    }
  } catch (e) {
    throw e.toString();
  }
}

String findKey(Map<String, dynamic> map) {
  for (var entry in map.entries) {
    if (entry.value is Map && entry.value['identifier'] != null) {
      List<int> identifierValue = List<int>.from(entry.value['identifier']);
      if (identifierValue.toString() != "[]") {
        debugPrint(identifierValue.toString());
        return identifierValue.toString();
      }
    }
  }
  return "[]";
}

final List<Month> engMonth = [
  Month(0, 'January'),
  Month(1, 'Febuary'),
  Month(2, 'March'),
  Month(3, 'April'),
  Month(4, 'May'),
  Month(5, 'June'),
  Month(6, 'July'),
  Month(7, 'August'),
  Month(8, 'September'),
  Month(9, 'October'),
  Month(10, 'November'),
  Month(11, 'December'),
];

final List<Month> nepaliMonth = [
  Month(0, 'Baisakh'),
  Month(1, 'Jestha'),
  Month(2, 'Asadh'),
  Month(3, 'Shwaran'),
  Month(4, 'Bhadra'),
  Month(5, 'Asoj'),
  Month(6, 'Kartik'),
  Month(7, 'Mangsir'),
  Month(8, 'Poush'),
  Month(9, 'Magh'),
  Month(10, 'Falgun'),
  Month(11, 'Chaitra'),
];

int calc() {
  return 10 - 5;
}

void value() {
  int value = calc();
}

bool getAppTheme() {
  final box = GetStorage();
  return box.read('theme') ?? true;
}

bool getAnimation() {
  final box = GetStorage();
  return box.read('animation') ?? true;
}

String appTheme = "#011754";
String appAlternateTheme = "#041033";

String radialBoxTheme = appAlternateTheme;

//light theme constant
String ltextColor = "#000000";

//dark theme constant
String dtextColor = "#ffffff";
