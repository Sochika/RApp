import 'dart:convert';
import 'dart:developer';

import 'package:radius/data/source/datastore/preferences.dart';
import 'package:radius/data/source/network/connect.dart';

import 'package:radius/utils/constant.dart';

import '../data/source/network/model/settings/SettingsResponse.dart';

class SettingsRepository {
  Future<SettingsResponse> getSettingReport() async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await Connect().getResponse(
          Constant.SETTINGS_URL,
          headers);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        log(responseData.toString());

        final responseJson = SettingsResponse.fromJson(responseData);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      throw unknownError(error);
    }
  }

  // Future<bool> getDateInAd() async {
  //   Preferences preferences = Preferences();
  //   bool value = await preferences.getEnglishDate();
  //
  //   return value;
  // }
}
