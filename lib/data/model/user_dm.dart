class UserDataModel {
  final String? id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final int avaterId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserDataModel({
    this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avaterId,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["_id"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      avaterId: json["avaterId"] ?? 0,
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
      "avaterId": avaterId,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}
