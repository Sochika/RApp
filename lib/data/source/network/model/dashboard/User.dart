class User {
  final int userId;
  final bool logoutStatus;
  final Staff staff;

  User({
    required this.userId,
    required this.logoutStatus,
    required this.staff,
  });

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? 0,  // Default to 0 if user_id is not present
      logoutStatus: json['logout_status'] ?? false,  // Default to false if logout_status is not present
      staff: Staff.fromJson(json['staff'] ?? {}),  // Create Staff instance from nested JSON
    );
  }

  // Method to convert User instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'logout_status': logoutStatus,
      'staff': staff.toJson(),
    };
  }
}

class Staff {
  final String firstName;
  final String lastName;
  final String avatar;
  final String gender;
  final String staff_no;
  final String hire_date;
  final String dob;

  Staff({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.gender,
    required this.staff_no,
    required this.hire_date,
    required this.dob,
  });

  // Factory constructor to create a Staff instance from JSON
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      firstName: json['first_name'] ?? '',  // Default to empty string if first_name is not present
      lastName: json['last_name'] ?? '',  // Default to empty string if last_name is not present
      avatar: json['avatar'] ?? '',  // Default to empty string if avatar is not present
      gender: json['gender'] ?? '',  // Default to empty string if last_name is not present
      staff_no: json['staff_no'] ?? '',  // Default to empty string if avatar is not present
      hire_date: json['hire_date'] ?? '',
      dob:json['date_of_birth'] ?? '',
    );
  }

  // Method to convert Staff instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'gender': gender,
      'staff_no': staff_no,
      'hire_date': hire_date,
      'date_of_birth': dob,
    };
  }

  // Method to return the avatar URL or default image if avatar is not set
  String getAvatarUrl() {
    if (avatar.isNotEmpty) {
      return 'path/to/avatar/$avatar';  // Replace with actual path or URL
    }
    return 'assets/images/img.png';  // Default image if avatar is missing
  }
}
