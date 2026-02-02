import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model for data layer - handles JSON serialization with Freezed
@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
  }) = _UserModel;

  /// Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert to domain entity
  User toEntity() => User(id: id, name: name, username: username, email: email);

  /// Create from domain entity
  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    name: user.name,
    username: user.username,
    email: user.email,
  );
}
