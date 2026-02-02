import '../entities/post.dart';
import '../entities/user.dart';

/// Abstract repository interface for posts feature
abstract class PostRepository {
  /// Fetches all posts from the API
  Future<List<Post>> getPosts();

  /// Fetches all users from the API
  Future<List<User>> getUsers();

  /// Gets list of bookmarked post IDs from local storage
  Future<Set<int>> getBookmarkedPostIds();

  /// Adds a post ID to bookmarks
  Future<void> addBookmark(int postId);

  /// Removes a post ID from bookmarks
  Future<void> removeBookmark(int postId);
}
