class UpdateUserRequestModel {
  final String name;
  final String email;
  final String phone;

  UpdateUserRequestModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}