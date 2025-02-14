import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/source/datastore/preferences.dart';
import '../../data/source/network/model/settings/SettingsResponse.dart';
import '../../utils/constant.dart';

class SettingsService {
  final Preferences _preferences;

  SettingsService(this._preferences);

  /// Fetches application settings from the server
  /// Returns [SettingsResponse] on success
  /// Throws formatted exceptions on failure
  Future<SettingsResponse> getSettingReport() async {
    try {
      final uri = await _buildSettingsUri();
      final headers = await _buildHeaders();

      final response = await http.get(uri, headers: headers);
      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw _handleNetworkError(e);
    } on FormatException catch (e) {
      throw _handleFormatError(e);
    } catch (e) {
      throw _handleGenericError(e);
    }
  }

  Future<Uri> _buildSettingsUri() async {
    final baseUrl = await _preferences.getAppUrl();
    return Uri.parse('$baseUrl${Constant.SETTINGS_URL}');
  }

  Future<Map<String, String>> _buildHeaders() async {
    final token = await _preferences.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  SettingsResponse _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body);

    if (statusCode == 200) {
      return SettingsResponse.fromJson(responseBody);
    }

    final errorMessage = responseBody['message'] ??
        'Failed to load settings (HTTP $statusCode)';
    throw AppException(errorMessage);
  }

  AppException _handleNetworkError(http.ClientException e) {
    return AppException('Network error: ${e.message}');
  }

  AppException _handleFormatError(FormatException e) {
    return AppException('Data format error: ${e.message}');
  }

  AppException _handleGenericError(dynamic e) {
    return AppException('Unexpected error: ${e.toString()}');
  }
}

// Custom exception class
class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}