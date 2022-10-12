class UserLoginResponseDto {

  final String token;
  final String email;
  final adopterId;

  const UserLoginResponseDto({
    required this.token,
    required this.email,
    required this.adopterId,
  });

  factory UserLoginResponseDto.fromJson(Map<String, dynamic> json) {
    return UserLoginResponseDto(
      token: json['token'],
      email: json['email'],
      adopterId: json['adopterId'],
    );
  }

}
