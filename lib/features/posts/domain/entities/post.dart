import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// Post entity representing the domain model
@freezed
class Post with _$Post {
  const factory Post({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _Post;
}
