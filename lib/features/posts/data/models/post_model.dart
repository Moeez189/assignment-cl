import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

/// Post model for data layer - handles JSON serialization with Freezed
@freezed
class PostModel with _$PostModel {
  const PostModel._();

  const factory PostModel({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostModel;

  /// Factory constructor to create PostModel from JSON
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  /// Convert to domain entity
  Post toEntity() => Post(id: id, userId: userId, title: title, body: body);

  /// Create from domain entity
  factory PostModel.fromEntity(Post post) => PostModel(
    id: post.id,
    userId: post.userId,
    title: post.title,
    body: post.body,
  );
}
