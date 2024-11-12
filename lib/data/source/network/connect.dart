import 'package:radius/data/source/datastore/preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class Connect {
  Future<http.Response> getResponse(
      String url, Map<String, String> headers) async {
    Preferences preferences = Preferences();
    final storage = GetStorage();
    String language = storage.read("language") ?? "en";

    headers.addEntries({
      "langauge": language,
    }.entries);

    var uri = Uri.parse(await preferences.getAppUrl() + url);
    return http.get(uri, headers: headers);
  }

  Future<http.Response> postResponse(
      String url, Map<String, String> headers, Map<String, String> body) async {
    Preferences preferences = Preferences();
    final storage = GetStorage();
    String language = storage.read("language") ?? "en";

    headers.addEntries({
      "langauge": language,
    }.entries);

    var uri = Uri.parse(await preferences.getAppUrl() + url);
    return http.post(uri, headers: headers, body: body);
  }
}
