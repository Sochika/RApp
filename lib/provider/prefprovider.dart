import 'package:radius/data/source/datastore/preferences.dart';
import 'package:flutter/material.dart';
import 'package:radius/data/source/network/model/login/Login.dart';
import 'package:radius/data/source/network/model/login/User.dart';

class PrefProvider with ChangeNotifier {
  var _staffNo = '';
  var _fullname = '';
  var _avatar = '';
  var _auth = false;
  var _attendanceType = "NFC";

  String get staffNo {
    return _staffNo;
  }

  String get fullname {
    return _fullname;
  }

  String get avatar {
    return _avatar;
  }

  String get attendanceType {
    return _attendanceType;
  }

  bool get auth {
    return _auth;
  }


  void getUser() async {
    Preferences preferences = Preferences();

    _staffNo = await preferences.getStaffNo();
    _fullname = await preferences.getFullName();
    _avatar = await preferences.getAvatar();
    notifyListeners();
  }

  Future<bool> getUserAuth() async {
    Preferences preferences = Preferences();
    return await preferences.getUserAuth();
  }

  void saveUser(Login data) async {
    Preferences preferences = Preferences();
    preferences.saveUser(data);
    notifyListeners();
  }

  void saveBasicUser(User user) async {
    Preferences preferences = Preferences();
    preferences.saveBasicUser(user);
    notifyListeners();
  }

  void saveEngDateEnabled(bool value) async {
    Preferences preferences = Preferences();
    preferences.saveAppEng(value);
  }

  Future<bool> getIsAd() async {
    Preferences preferences = Preferences();
    return await preferences.getEnglishDate();
  }

  Future<String> getAttendanceType() async {
    Preferences preferences = Preferences();
    _attendanceType = await preferences.getAttendanceType();
    return _attendanceType;
  }

  void saveAuth(bool value) async {
    Preferences preferences = Preferences();
    preferences.saveUserAuth(value);

    _auth = await preferences.getUserAuth();
    notifyListeners();
  }

  void saveAttendanceType(String type) async {
    Preferences preferences = Preferences();
    preferences.saveAttendanceType(type);

    _attendanceType = await preferences.getAttendanceType();
    notifyListeners();
  }
}
