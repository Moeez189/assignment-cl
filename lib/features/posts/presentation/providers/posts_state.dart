import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';

part 'posts_state.freezed.dart';

/// Represents a post with its associated user information
@freezed
class PostWithUser with _$PostWithUser {
  const PostWithUser._();

  const factory PostWithUser({
    required Post post,
    User? user,
    @Default(false) bool isBookmarked,
  }) = _PostWithUser;

  /// Author name - returns user name or 'Unknown' if user is null
  String get authorName => user?.name ?? 'Unknown Author';
}

/// State for the posts feature
enum PostsStatus { initial, loading, loaded, error }

@freezed
class PostsState with _$PostsState {
  const PostsState._();

  const factory PostsState({
    @Default(PostsStatus.initial) PostsStatus status,
    @Default([]) List<PostWithUser> posts,
    @Default({}) Set<int> bookmarkedIds,
    @Default('') String searchQuery,
    @Default(false) bool showBookmarksOnly,
    String? errorMessage,
  }) = _PostsState;

  /// Returns only bookmarked posts (for bookmarks screen).
  List<PostWithUser> get bookmarkedPosts =>
      posts.where((p) => bookmarkedIds.contains(p.post.id)).toList();

  /// Returns filtered posts based on search query and bookmark filter
  List<PostWithUser> get filteredPosts {
    var filtered = posts;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered =
          filtered
              .where(
                (p) => p.post.title.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
              )
              .toList();
    }

    // Filter by bookmarks only
    if (showBookmarksOnly) {
      filtered =
          filtered.where((p) => bookmarkedIds.contains(p.post.id)).toList();
    }

    return filtered;
  }
}
