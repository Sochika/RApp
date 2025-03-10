
import 'package:radius/data/source/network/model/changepassword/ChangePasswordResponse.dart';
import 'package:radius/repositories/changepasswordrepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:radius/repositories/locationoperativerepository.dart';

class LocationOperativeProvider with ChangeNotifier {
  LocationOperativeRepository repository = LocationOperativeRepository();

  Future<ChangePasswordResponse> locationUpdate(
      String latitude, String longitude, String address) async {
    try {
      final response =
          await repository.LocationUpdate(latitude, longitude, address);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
