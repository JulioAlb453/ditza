import '../../domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.alias,
    required super.email,
    required super.coins,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? json['user_id']) as String,
      alias: json['alias'] as String,
      email: json['email'] as String,
      coins: json['coins'] as int? ?? 0,
    );
  }
}
