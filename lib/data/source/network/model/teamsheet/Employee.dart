// class Employee {
//   Employee({
//     required this.id,
//     required this.first_name,
//     required this.last_name,
//     required this.email,
//     required this.username,
//     required this.phone,
//     required this.dob,
//     required this.gender,
//     required this.role,
//     required this.avatar,
//     required this.onlineStatus,
//   });
//
//   factory Employee.fromJson(dynamic json) {
//     return Employee(
//         id: json['id'],
//         first_name: json['first_name'].toString() ?? "",
//         last_name: json['last_name'].toString() ?? "",
//         email: json['email'].toString() ?? "",
//         username: json['username'].toString() ?? "",
//         phone: json['phone'].toString() ?? "",
//         dob: json['dob'].toString() ?? "",
//         gender: json['gender'].toString() ?? "",
//         role: json['role'].toString() ?? "",
//
//         avatar: json['avatar'].toString() ?? "",
//         onlineStatus: json['online_status'].toString() ?? "0");
//   }
//
//   int id;
//   String first_name;
//   String last_name;
//   String email;
//   String phone;
//   String username;
//   String dob;
//   String gender;
//   String role;
//
//   String avatar;
//   String onlineStatus;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = first_name;
//     map['name'] = last_name;
//     map['email'] = email;
//     map['phone'] = phone;
//     map['dob'] = dob;
//     map['gender'] = gender;
//
//     map['avatar'] = avatar;
//     map['online_status'] = onlineStatus;
//     return map;
//   }
// }
