class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.gender,
    required this.staffNo,
    required this.hireDate,
    required this.dob,
  });

  // Factory method to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '',
      gender: json['gender'] ?? '',
      staffNo: json['staff_no'] ?? '',
      hireDate: json['hire_date'] ?? '',
      dob: json['date_of_birth'] ?? '',
    );
  }

  final int id;
  final String firstName;
  final String lastName;
  final String avatar;
  final String gender;
  final String staffNo;
  final String hireDate;
  final String dob;

  // Method to convert a User instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'gender': gender,
      'staff_no': staffNo,
      'hire_date': hireDate,
      'date_of_birth': dob,
    };
  }
}
