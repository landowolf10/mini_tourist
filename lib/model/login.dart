class Login {
  String email;
  String password;

  Login({
    required this.email,
    required this.password
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['email']?.toString() ?? '',
      password: json['password']?.toString() ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password
    };
  }
}