import 'package:radius/data/source/network/model/employeedetailresponse/AllAward.dart';

class Data {
  String address;
  String avatar;
  String branch;
  String department;
  String dob;
  String employment_type;
  String gender;
  String joining_date;
  String name;
  String phone;
  String post;
  String user_type;
  String username;
  List<AllAward> all_awards;

  Data(
      {required this.address,
      required this.avatar,
      required this.branch,
      required this.department,
      required this.dob,
      required this.employment_type,
      required this.gender,
      required this.joining_date,
      required this.name,
      required this.phone,
      required this.post,
      required this.user_type,
      required this.username,
      required this.all_awards});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      address: json['address'],
      avatar: json['avatar'],
      branch: json['branch'],
      department: json['department'],
      dob: json['dob'],
      employment_type: json['employment_type'],
      gender: json['gender'],
      joining_date: json['joining_date'],
      name: json['name'],
      phone: json['phone'].toString(),
      post: json['post'],
      user_type: json['user_type'],
      username: json['username'],
      all_awards: (json['awards'] as List)
          .map((i) => AllAward.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['avatar'] = avatar;
    data['branch'] = branch;
    data['department'] = department;
    data['dob'] = dob;
    data['employment_type'] = employment_type;
    data['gender'] = gender;
    data['joining_date'] = joining_date;
    data['name'] = name;
    data['phone'] = phone;
    data['post'] = post;
    data['user_type'] = user_type;
    data['username'] = username;
    return data;
  }
}
