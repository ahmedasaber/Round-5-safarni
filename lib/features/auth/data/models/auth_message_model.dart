class AuthMessageModel {
  final int status;
  final String message;

  AuthMessageModel({
    required this.status,
    required this.message,
  });

  factory AuthMessageModel.fromJson(Map<String, dynamic> json) {
    return AuthMessageModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
