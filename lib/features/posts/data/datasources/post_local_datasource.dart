import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/utils/app_logger.dart';

/// Abstract class for local data source (bookmarks)
abstract class PostLocalDataSource {
  /// Gets bookmarked post IDs
  Future<Set<int>> getBookmarkedPostIds();

  /// Adds a post ID to bookmarks
  Future<void> addBookmark(int postId);

  /// Removes a post ID from bookmarks
  Future<void> removeBookmark(int postId);
}

/// Implementation of PostLocalDataSource using SharedPreferences
class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Set<int>> getBookmarkedPostIds() async {
    try {
      final jsonString = sharedPreferences.getString(
        StorageConstants.bookmarkedPostsKey,
      );
      if (jsonString == null) {
        return {};
      }
      final List<dynamic> jsonList = json.decode(jsonString);
      final bookmarks = jsonList.map((e) => e as int).toSet();
      AppLogger.d('Loaded ${bookmarks.length} bookmarks');
      return bookmarks;
    } catch (e) {
      AppLogger.e('Failed to get bookmarks', e);
      return {};
    }
  }

  @override
  Future<void> addBookmark(int postId) async {
    try {
      final bookmarks = await getBookmarkedPostIds();
      bookmarks.add(postId);
      await _saveBookmarks(bookmarks);
      AppLogger.i('Added bookmark for post $postId');
    } catch (e) {
      AppLogger.e('Failed to add bookmark', e);
      rethrow;
    }
  }

  @override
  Future<void> removeBookmark(int postId) async {
    try {
      final bookmarks = await getBookmarkedPostIds();
      bookmarks.remove(postId);
      await _saveBookmarks(bookmarks);
      AppLogger.i('Removed bookmark for post $postId');
    } catch (e) {
      AppLogger.e('Failed to remove bookmark', e);
      rethrow;
    }
  }

  Future<void> _saveBookmarks(Set<int> bookmarks) async {
    final jsonString = json.encode(bookmarks.toList());
    await sharedPreferences.setString(
      StorageConstants.bookmarkedPostsKey,
      jsonString,
    );
  }
}
