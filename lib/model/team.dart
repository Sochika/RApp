import 'package:flutter/material.dart';

class Team with ChangeNotifier {
  int id;
  String username;
  String first_name;
  String last_name;

  String avatar;
  String phone;
  String email;
  // String active;
  String role;


  Team(
      {required this.id,
      required this.username,
      required this.first_name,
        required this.last_name,

      required this.avatar,
      required this.phone,
      required this.email,
      // required this.active,
      required this.role,

      });
}
