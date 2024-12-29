import 'User.dart';

class Login {
  const Login({
    required this.user,
    required this.tokens,
    required this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      user: User.fromJson(json['user'] ?? {}),
      tokens: json['token_type']?.toString() ?? '',
      token: json['access_token']?.toString() ?? '',
    );
  }

  final User user;
  final String tokens;
  final String token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user.toJson();
    map['token_type'] = tokens;
    map['access_token'] = token;
    return map;
  }
}
