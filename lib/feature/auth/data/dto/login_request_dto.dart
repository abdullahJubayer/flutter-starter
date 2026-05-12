class LoginRequestDto {
  const LoginRequestDto({
    required this.email,
    required this.password,
    required this.phone,
  });

  final String email;
  final String password;
  final String phone;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'password': password,
    };

    if (email.trim().isNotEmpty) {
      data['email'] = email.trim();
    }

    if (phone.trim().isNotEmpty) {
      data['phone'] = phone.trim();
    }

    return data;
  }
}

