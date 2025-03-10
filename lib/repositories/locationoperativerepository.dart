import 'dart:convert';

import 'package:radius/data/source/datastore/preferences.dart';
import 'package:radius/data/source/network/connect.dart';
import 'package:radius/data/source/network/model/changepassword/ChangePasswordResponse.dart';
import 'package:radius/utils/constant.dart';
import 'package:flutter/material.dart';

class LocationOperativeRepository{
  Future<ChangePasswordResponse> LocationUpdate(
      String latitude, String longitude, String address) async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    final body = {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };

    try {
      final response = await Connect().postResponse(Constant.LOCATIONOPERATIVE_URL, headers, body);
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = ChangePasswordResponse.fromJson(responseData);

        return jsonResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      throw unknownError(e);
    }
  }
}