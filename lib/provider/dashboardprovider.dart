import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:math' as Random;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:radius/data/source/datastore/preferences.dart';
import 'package:radius/data/source/network/model/attendancestatus/AttendanceStatusResponse.dart';
import 'package:radius/data/source/network/model/dashboard/Dashboardresponse.dart';
import 'package:radius/data/source/network/model/dashboard/EmployeeTodayAttendance.dart';
import 'package:radius/data/source/network/model/dashboard/Feature.dart';
import 'package:radius/data/source/network/model/dashboard/Overview.dart';
import 'package:radius/data/source/network/model/teamsheet/Employee.dart';
import 'package:radius/model/award.dart';
import 'package:radius/model/holiday.dart';
import 'package:radius/utils/constant.dart';
import 'package:radius/utils/locationstatus.dart';
import 'package:radius/utils/wifiinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor_plus/http_interceptor_plus.dart';
import 'package:intl/intl.dart';
// import 'package:nepali_date_picker/nepali_date_picker.dart';

class DashboardProvider with ChangeNotifier {
  final Map<String, String> _overviewList = {
    'present': '0',
    'holiday': '0',
    'leave': '0',
    'request': '0',
    'total_project': '0',
    'total_task': '0',
    'total_awards': '0',
    'active_training': '0',
  };

  final Map<String, dynamic> locationStatus = {
    'latitude': 0.0,
    'longitude': 0.0,
    'address' : '',
  };

  var department = "";
  var branch = "";

  Map<String, String> get overviewList {
    return _overviewList;
  }

  final Map<String, dynamic> _attendanceList = {
    'check-in': '-',
    'check-out': '-',
    'production_hour': '0 hr 0 min',
    'production-time': 0.0
  };

  // List<Employee> employeeList = [];

  bool isAD = true;
  bool isNoteEnabled = false;
  bool animated = true;
  bool isBirthdayWished = false;

  Holiday? holiday;
  Award? award;


  final noteController = TextEditingController();

  Map<String, dynamic> get attendanceList {
    return _attendanceList;
  }

  final List<int> _weeklyReport = [];

  List<int> get weeklyReport {
    return _weeklyReport;
  }

  List<BarChartGroupData> barchartValue = [];

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  void buildgraph() {
    const int daysInWeek = 7;
    for (int i = 0; i < daysInWeek; i++) {
      barchartValue.add(makeGroupData(i, 0));
    }

    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);
  }

  Future<void> checkAD() async {
    Preferences preferences = Preferences();
    isAD = await preferences.getEnglishDate();
    notifyListeners();
  }

  Future<Dashboardresponse> getDashboard() async {
    Preferences preferences = Preferences();
    animated = getAnimation();

    var uri = Uri.parse(await preferences.getAppUrl() + Constant.DASHBOARD_URL);

    String token = await preferences.getToken();

    print('from dash$token');
    var fcm = await FirebaseMessaging.instance.getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'fcm_token': fcm ?? ""
    };

    final response = await http.get(uri, headers: headers);
    log(response.body.toString());

    final responseData = json.decode(response.body);

    print('from dashCode${response.statusCode}' );
    if (response.statusCode == 200) {

      final dashboardResponse = Dashboardresponse.fromJson(responseData);

      await preferences.saveUserDashboard(dashboardResponse.data.user);

      notifyListeners();
      return dashboardResponse;
    } else {
      var errorMessage = responseData['message'];
      print(errorMessage.toString());
      throw errorMessage;
    }
  }

  Future<Dashboardresponse> getOverview() async {
    Preferences preferences = Preferences();
    animated = getAnimation();

    var uri = Uri.parse(await preferences.getAppUrl() + Constant.OVERVIEW_URL);

    String token = await preferences.getToken();

    var fcm = await FirebaseMessaging.instance.getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'fcm_token': fcm ?? ""
    };

    final response = await http.get(uri, headers: headers);
    log(response.body.toString());

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {

      final dashboardResponse = Dashboardresponse.fromJson(responseData);
      // await preferences.saveUserDashboard(dashboardResponse.data.user);

      notifyListeners();
      return dashboardResponse;
    } else {
      var errorMessage = responseData['message'];
      print(errorMessage.toString());
      throw errorMessage;
    }
  }

  void makeWeeklyReport(List<dynamic> employeeWeeklyReport) {
    _weeklyReport.clear();
    for (var item in employeeWeeklyReport) {
      if (item != null) {
        int hr = (item['productive_time_in_min'] / 60).toInt();
        if (hr > Constant.TOTAL_WORKING_HOUR) {
          _weeklyReport.add(Constant.TOTAL_WORKING_HOUR);
        } else {
          _weeklyReport.add(hr);
        }
      } else {
        _weeklyReport.add(0);
      }
    }

    barchartValue.clear();
    rawBarGroups.clear();
    showingBarGroups.clear();
    for (int i = 0; i < _weeklyReport.length; i++) {
      barchartValue.add(makeGroupData(i, _weeklyReport[i].toDouble()));
    }

    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);

    notifyListeners();
  }

  void updateAttendanceStatus(EmployeeTodayAttendance employeeTodayAttendance) {
    _attendanceList.update('production-time',
            (value) =>
            calculateProdHour(employeeTodayAttendance.productionTime));
    _attendanceList.update(
        'check-out', (value) => employeeTodayAttendance.checkOutAt);
    _attendanceList.update('production_hour',
            (value) =>
            calculateHourText(employeeTodayAttendance.productionTime));
    _attendanceList.update(
        'check-in', (value) => employeeTodayAttendance.checkInAt);

    notifyListeners();
  }

  void updateOverView(Overview overview) {
    _overviewList.update('present', (value) => overview.presentDays.toString());
    _overviewList.update(
        'holiday', (value) => overview.totalHolidays.toString());
    _overviewList.update(
        'leave', (value) => overview.totalLeaveTaken.toString());
    _overviewList.update(
        'request', (value) => overview.totalPendingLeaves.toString());
    _overviewList.update('total_project',
            (value) => overview.total_assigned_projects.toString());
    _overviewList.update(
        'total_task', (value) => overview.total_pending_tasks.toString());
    _overviewList.update(
        'total_awards', (value) => overview.total_awards.toString());
    _overviewList.update(
        'active_training', (value) => overview.active_training.toString());

    notifyListeners();
  }

  double calculateProdHour(int value) {
    double hour = value / 60;
    double hr = hour / Constant.TOTAL_WORKING_HOUR;

    return hr > 1 ? 1 : hr;
  }

  String calculateHourText(int value) {
    double second = value * 60.toDouble();
    double min = second / 60;
    int minGone = (min % 60).toInt();
    int hour = min ~/ 60;

    print("$hour hr $minGone min");
    return "$hour hr $minGone min";
  }

  void controlFeatures(List<Feature> features) {
    Preferences preferences = Preferences();
    Map<String, String> featureList = <String, String>{};

    for (var feature in features) {
      featureList[feature.key] = feature.status;
    }

    preferences.setFeatures(featureList);
  }

  Future<bool> getCheckInStatus() async {
    try {
      Preferences preferences = Preferences();
      final position = await LocationStatus()
          .determinePosition(await preferences.getWorkSpace());
      print(position);

      locationStatus.update('latitude', (value) => position.latitude);

      // Return true to indicate success in fetching position and updating status
      return true;
    } catch (e) {
      // Optionally print the error for debugging
      print('Error occurred: $e');
      return false; // Return false to indicate failure
    }
  }

  Future<AttendanceStatusResponse> checkInAttendance() async {
    Preferences preferences = Preferences();
    var uri = Uri.parse(await preferences.getAppUrl() + Constant.CHECK_IN_URL);

    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(uri, headers: headers, body: {
      // 'router_bssid': await WifiInfo().info.getWifiBSSID() ?? "",
      'check_in_latitude': locationStatus['latitude'].toString(),
      'check_in_longitude': locationStatus['longitude'].toString(),
      'address': locationStatus['longitude'].toString(),
    });

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final attendanceResponse =
      AttendanceStatusResponse.fromJson(responseData);
      debugPrint(attendanceResponse.toString());

      updateAttendanceStatus(EmployeeTodayAttendance(
          checkInAt: attendanceResponse.data.checkInAt,
          checkOutAt: attendanceResponse.data.checkOutAt,
          productionTime: attendanceResponse.data.productiveTimeInMin));

      return attendanceResponse;
    } else {
      var errorMessage = responseData['message'];
      throw errorMessage;
    }
  }

  Future<void> scheduleNewNotification(String date,
      String startMessage,
      int startHr,
      int startMin,
      String endMessage,
      int endHr,
      int endMin) async {
    final convertedDate = DateFormat('yyyy-MM-dd').parse(date);

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random.Random().nextInt(1000000),
            // -1 is replaced by a random number
            channelKey: 'digital_hr_channel',
            title: "Hello There",
            body: startMessage,
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.Default,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
              key: 'REDIRECT', label: 'Open', actionType: ActionType.Default),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime(convertedDate.year, convertedDate.month,
                convertedDate.day, startHr, startMin - 15)));

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random.Random().nextInt(1000000),
            // -1 is replaced by a random number
            channelKey: 'digital_hr_channel',
            title: "Hello There",
            body: endMessage,
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.Default,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
              key: 'REDIRECT', label: 'Open', actionType: ActionType.Default),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime(convertedDate.year, convertedDate.month,
                convertedDate.day, endHr, endMin - 15)));
  }

  Future<AttendanceStatusResponse> checkOutAttendance() async {
    Preferences preferences = Preferences();
    var uri = Uri.parse(await preferences.getAppUrl() + Constant.CHECK_OUT_URL);

    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(uri, headers: headers, body: {
      'router_bssid': await WifiInfo().wifiBSSID() ?? "",
      'check_out_latitude': locationStatus['latitude'].toString(),
      'check_out_longitude': locationStatus['longitude'].toString(),
    });
    debugPrint(response.body.toString());

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final attendanceResponse =
      AttendanceStatusResponse.fromJson(responseData);

      updateAttendanceStatus(EmployeeTodayAttendance(
          checkInAt: attendanceResponse.data.checkInAt,
          checkOutAt: attendanceResponse.data.checkOutAt,
          productionTime: attendanceResponse.data.productiveTimeInMin));

      return attendanceResponse;
    } else {
      var errorMessage = responseData['message'];
      throw errorMessage;
    }
  }

  Future<AttendanceStatusResponse> verifyAttendanceApi(String type,String note,
      {String attendanceStatus = "", String identifier = ""}) async {
    Preferences preferences = Preferences();
    var uri =
    Uri.parse(await preferences.getAppUrl() + Constant.ATTENDANCE_URL);
    print(identifier);

    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    final http.Client client = LoggingMiddleware(http.Client());

    final response = await client.post(uri, headers: headers, body: {
      'attendance_type': type,
      'latitude': locationStatus['latitude'].toString(),
      'longitude': locationStatus['longitude'].toString() ,
      'note': 'From App',
    });

    log(response.body.toString());

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final attendanceResponse =
      AttendanceStatusResponse.fromJson(responseData);

      updateAttendanceStatus(EmployeeTodayAttendance(
          checkInAt: attendanceResponse.data.checkInAt,
          checkOutAt: attendanceResponse.data.checkOutAt,
          productionTime: attendanceResponse.data.productiveTimeInMin));
      noteController.clear();
      return attendanceResponse;
    } else {
      var errorMessage = responseData['message'];
      throw errorMessage;
    }
  }

  final Color leftBarColor = HexColor("#FFFFFF");

  final double width = 15;

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        toY: y1,
        color: leftBarColor,
        width: width,
      ),
    ]);
  }
}
