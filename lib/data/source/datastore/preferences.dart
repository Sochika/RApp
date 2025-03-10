import 'package:radius/data/source/network/model/login/User.dart';
import 'package:radius/data/source/network/model/dashboard/User.dart' as DashboardUser;
import 'package:radius/data/source/network/model/login/Login.dart';
import 'package:radius/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier {
  final String USER_ID = "user_id";
  final String USER_AVATAR = "user_avatar";
  final String USER_TOKEN = "user_token";
  final String SESSION_TOKEN = "session_token";
  final String USER_STAFFNO = "user_staffNo";
  final String GENDER = "gender";
  final String DOB = "date_of_birth";
  final String USER_FULLNAME = "user_fullname";
  final String USER_AUTH = "user_auth";
  final String WORKSPACE = "workspace_type";
  final String APP_IN_ENGLISH = "eng_date";
  final String ATTENDANCE_TYPE = "attendance_type";
  final String APP_URL = "app_url";
  final String HARD_RESET_APP = "HARD_RESET";
  final String BIRTHDAY_WISHED = "BIRTHDAY_WISHED";
  final String SHOW_NFC = "SHOW_NFC";
  final String SHOWNOTE = "SHOW_NOTE";

  //feature control
  final String PROJECT_MANAGEMENT = "project-management";
  final String MEETING = "meeting";
  final String TADA = "tada";
  final String PAYROLL_MANGEMENT = "payroll-management";
  final String ADVANCE_SALARY = "advance-salary";
  final String SUPPORT = "support";
  final String DARK_MODE = "dark-mode";
  final String NFC_QR = "nfc-qr";
  final String AWARD = "award";
  final String TRAINING = "training";
  final String LOAN = "loan";

  Future<bool> saveUser(Login data) async {
    // Obtain shared preferences.
    User user = data.user;
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(USER_TOKEN, data.tokens);
    await prefs.setString(SESSION_TOKEN, data.token);
    await prefs.setInt(USER_ID, user.id);
    await prefs.setString(USER_AVATAR, user.avatar);
    await prefs.setString(USER_STAFFNO, user.staffNo);
    await prefs.setString(GENDER, user.gender);
    await prefs.setString(USER_FULLNAME, '${user.firstName} ${user.lastName}');
    await prefs.setString(WORKSPACE, user.hireDate);

    notifyListeners();

    return true;
  }

  Future<bool> saveUserDashboard(DashboardUser.User user) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(USER_ID, user.userId);
    await prefs.setString(USER_AVATAR, user.staff.avatar);
    await prefs.setString(USER_STAFFNO, user.staff.staff_no);
    await prefs.setString(GENDER, user.staff.gender);
    await prefs.setString(USER_FULLNAME, '${user.staff.firstName} ${user.staff.lastName}');
    await prefs.setString(WORKSPACE, user.staff.hire_date);
    await prefs.setString(DOB, user.staff.dob);

    notifyListeners();

    return true;
  }

  Future<void> setFeatures(Map<String, String> features) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(PROJECT_MANAGEMENT, features["project-management"]!);
    await prefs.setString(MEETING, features["meeting"]!);
    await prefs.setString(TADA, features["tada"]!);
    await prefs.setString(PAYROLL_MANGEMENT, features["payroll-management"]!);
    await prefs.setString(ADVANCE_SALARY, features["advance-salary"]!);
    await prefs.setString(SUPPORT, features["support"]!);
    await prefs.setString(DARK_MODE, features["dark-mode"]!);
    await prefs.setString(NFC_QR, features["nfc-qr"]!);
    await prefs.setString(AWARD, features["award"]!);
    await prefs.setString(TRAINING, features["training"]!);
    await prefs.setString(LOAN, features["loan"]!);

    notifyListeners();
  }

  Future<Map<String, String>> getFeatures() async {
    Map<String, String> features = <String, String>{};
    final prefs = await SharedPreferences.getInstance();

    features["project-management"] =
        prefs.getString(PROJECT_MANAGEMENT) ?? "1";
    features["meeting"] = prefs.getString(MEETING) ?? "1";
    features["tada"] = prefs.getString(TADA) ?? "1";
    features["payroll-management"] =
        prefs.getString(PAYROLL_MANGEMENT) ?? "1";
    features["advance-salary"] = prefs.getString(ADVANCE_SALARY) ?? "1";
    features["support"] = prefs.getString(SUPPORT) ?? "1";
    features["dark-mode"] = prefs.getString(DARK_MODE) ?? "1";
    features["nfc-qr"] = prefs.getString(NFC_QR) ?? "1";
    features["award"] = prefs.getString(AWARD) ?? "1";
    features["training"] = prefs.getString(TRAINING) ?? "1";
    features["loan"] = prefs.getString(LOAN) ?? "1";

    return features;
  }

  void saveBasicUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(USER_ID, user.id);
    await prefs.setString(USER_AVATAR, user.avatar);
    await prefs.setString(USER_STAFFNO, user.staffNo);
    await prefs.setString(GENDER, user.gender);
    await prefs.setString(USER_FULLNAME, '${user.firstName} ${user.lastName}');
    await prefs.setString(WORKSPACE, user.dob);

    notifyListeners();
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(USER_ID, 0);
    await prefs.setString(USER_TOKEN, '');
    await prefs.setString(SESSION_TOKEN, '');
    await prefs.setString(USER_AVATAR, '');
    await prefs.setString(USER_STAFFNO, '');
    await prefs.setString(GENDER, '');
    await prefs.setString(USER_FULLNAME, '');
    await prefs.setBool(USER_AUTH, false);
    await prefs.setBool(APP_IN_ENGLISH, true);
    await prefs.setString(WORKSPACE, "1");
    await prefs.setString(ATTENDANCE_TYPE, "Default");
    await prefs.setString(APP_URL, "");

    notifyListeners();
  }

  void saveUserAuth(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(USER_AUTH, value);
  }

  void saveShowNfc(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SHOW_NFC, value);
  }

  void saveHardReset(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(HARD_RESET_APP, value);
  }

  void saveAppUrl(String value) async {
    // String kvalue = value ?? Constant.appUrl;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(APP_URL, Constant.appUrl);
  }

  void saveAttendanceType(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ATTENDANCE_TYPE, value);
    notifyListeners();
  }

  void saveAppEng(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(APP_IN_ENGLISH, value);
  }

  void saveBirthdayWished(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(BIRTHDAY_WISHED, value);
  }

  void saveNote(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SHOWNOTE, value);
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    String fullName = prefs.getString(USER_FULLNAME) ?? "";
    List<String> nameParts = fullName.split(" ");
    return User(
      id: prefs.getInt(USER_ID) ?? 0,  // Default value if the ID is not found
      firstName: nameParts.isNotEmpty ? nameParts.first : "",  // First part of the name
      lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",  // The rest of the name
      dob: prefs.getString(DOB) ?? "",  // Default to empty if DOB is not found
      avatar: prefs.getString(USER_AVATAR) ?? "",  // Default to empty if avatar is not found
      gender: prefs.getString(GENDER) ?? '',
      hireDate: prefs.getString(WORKSPACE) ?? "1",  // Default to "1" if workspace (hire date) is missing
      staffNo: prefs.getString(USER_STAFFNO) ?? "",  // Default to empty if staff number is missing
      // Default to empty if gender is not found
    );

  }

  Future<String> getsToken() async {
    final prefs = await SharedPreferences.getInstance();

    // print('from token0' + USER_TOKEN);
    return prefs.getString(USER_TOKEN) ?? "";
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    // print('from token0' + USER_TOKEN);
    return prefs.getString(SESSION_TOKEN) ?? "";
  }


  Future<bool> getNote() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(SHOWNOTE) ?? false;
  }

  Future<String> getAttendanceType() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(ATTENDANCE_TYPE) ?? "Default";
  }

  Future<bool> getUserAuth() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(USER_AUTH) ?? false;
  }

  Future<bool> getShowNfc() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(SHOW_NFC) ?? true;
  }

  Future<bool> getBirthdayWished() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(BIRTHDAY_WISHED) ?? false;
  }

  Future<String> getStaffNo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_STAFFNO) ?? "";
  }

  Future<String> getDOB() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(DOB) ?? "";
  }

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(GENDER) ?? "";
  }

  Future<String> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_AVATAR) ?? "";
  }

  Future<String> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_FULLNAME) ?? "";
  }

  Future<String> getWorkSpace() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(WORKSPACE) ?? "1";
  }

  Future<bool> getEnglishDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(APP_IN_ENGLISH) ?? true;
  }

  Future<String> getAppUrl() async {
    // final prefs = await SharedPreferences.getInstance();
    return Constant.appUrl;
  }

  Future<bool> getHardReset() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(HARD_RESET_APP) ?? true;
  }
}
