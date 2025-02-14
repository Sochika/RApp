// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../data/source/datastore/preferences.dart';
import '../data/source/network/model/settings/SettingsResponse.dart';
import '../repositories/settingsrepository.dart';
// import '../repositories/settingsrepository.dart';
// import '../utils/constant.dart';

class SettingsProvider extends ChangeNotifier {
SettingsResponse? _settings;

SettingsResponse? get settings => _settings;

Future<void> fetchSettings() async {
  try {
    _settings = await SettingsRepository().getSettingReport();
    print(_settings);
    notifyListeners();
  } catch (e) {
    throw Exception('Failed to fetch settings: $e');
  }
}
// Future<SettingsResponse> getSettingReport() async {
//   Preferences preferences = Preferences();
//   String token = await preferences.getToken();
//
//   Map<String, String> headers = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json; charset=UTF-8',
//     'Authorization': 'Bearer $token'
//   };
//
//   try {
//     final uri = Uri.parse("${await preferences.getAppUrl()}${Constant.SETTINGS_URL}");
//     final response = await http.get(uri, headers: headers);
//     final responseData = json.decode(response.body);
//
//     if (response.statusCode == 200) {
//       return SettingsResponse.fromJson(responseData);
//     } else {
//       var errorMessage = responseData['message'];
//       throw errorMessage;
//     }
//   } catch (error) {
//     throw unknownError(error); // Ensure unknownError() is defined
//   }
// }
}