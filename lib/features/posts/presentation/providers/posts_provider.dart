import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/app_logger.dart';
import '../../data/datasources/post_local_datasource.dart';
import '../../data/datasources/post_remote_datasource.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/usecases/usecases.dart';
import 'posts_state.dart';

/// Provider for Dio Client
final dioProvider = Provider<Dio>((ref) {
  return DioClient.instance;
});

/// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in main');
});

/// Provider for Remote Data Source
final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return PostRemoteDataSourceImpl(dio: dio);
});

/// Provider for Local Data Source
final postLocalDataSourceProvider = Provider<PostLocalDataSource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return PostLocalDataSourceImpl(sharedPreferences: sharedPreferences);
});

/// Provider for Post Repository
final postRepositoryProvider = Provider<PostRepository>((ref) {
  final remoteDataSource = ref.watch(postRemoteDataSourceProvider);
  final localDataSource = ref.watch(postLocalDataSourceProvider);
  return PostRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

// ==================== Use Case Providers ====================

/// Provider for GetPostsUseCase
final getPostsUseCaseProvider = Provider<GetPostsUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return GetPostsUseCase(repository);
});

/// Provider for GetUsersUseCase
final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return GetUsersUseCase(repository);
});

/// Provider for GetBookmarksUseCase
final getBookmarksUseCaseProvider = Provider<GetBookmarksUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return GetBookmarksUseCase(repository);
});

/// Provider for AddBookmarkUseCase
final addBookmarkUseCaseProvider = Provider<AddBookmarkUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return AddBookmarkUseCase(repository);
});

/// Provider for RemoveBookmarkUseCase
final removeBookmarkUseCaseProvider = Provider<RemoveBookmarkUseCase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return RemoveBookmarkUseCase(repository);
});

// ==================== State Notifier Provider ====================

/// Provider for Posts Notifier
final postsNotifierProvider = StateNotifierProvider<PostsNotifier, PostsState>((
  ref,
) {
  return PostsNotifier(
    getPostsUseCase: ref.watch(getPostsUseCaseProvider),
    getUsersUseCase: ref.watch(getUsersUseCaseProvider),
    getBookmarksUseCase: ref.watch(getBookmarksUseCaseProvider),
    addBookmarkUseCase: ref.watch(addBookmarkUseCaseProvider),
    removeBookmarkUseCase: ref.watch(removeBookmarkUseCaseProvider),
  );
});

/// StateNotifier for managing posts state
class PostsNotifier extends StateNotifier<PostsState> {
  final GetPostsUseCase _getPostsUseCase;
  final GetUsersUseCase _getUsersUseCase;
  final GetBookmarksUseCase _getBookmarksUseCase;
  final AddBookmarkUseCase _addBookmarkUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;

  PostsNotifier({
    required GetPostsUseCase getPostsUseCase,
    required GetUsersUseCase getUsersUseCase,
    required GetBookmarksUseCase getBookmarksUseCase,
    required AddBookmarkUseCase addBookmarkUseCase,
    required RemoveBookmarkUseCase removeBookmarkUseCase,
  }) : _getPostsUseCase = getPostsUseCase,
       _getUsersUseCase = getUsersUseCase,
       _getBookmarksUseCase = getBookmarksUseCase,
       _addBookmarkUseCase = addBookmarkUseCase,
       _removeBookmarkUseCase = removeBookmarkUseCase,
       super(const PostsState());

  /// Fetches posts and users, then combines them
  Future<void> fetchPosts() async {
    state = state.copyWith(status: PostsStatus.loading);

    try {
      // Fetch posts, users, and bookmarks in parallel using use cases
      final results = await Future.wait([
        _getPostsUseCase(),
        _getUsersUseCase(),
        _getBookmarksUseCase(),
      ]);

      final posts = results[0] as List;
      final users = results[1] as List;
      final bookmarkedIds = results[2] as Set<int>;

      // Create a map of userId -> User for quick lookup
      final userMap = {for (var user in users) user.id: user};

      // Combine posts with users
      final postsWithUsers =
          posts.map((post) {
            return PostWithUser(
              post: post,
              user: userMap[post.userId],
              isBookmarked: bookmarkedIds.contains(post.id),
            );
          }).toList();

      state = state.copyWith(
        status: PostsStatus.loaded,
        posts: postsWithUsers,
        bookmarkedIds: bookmarkedIds,
        errorMessage: null,
      );

      AppLogger.i('Loaded ${postsWithUsers.length} posts successfully');
    } catch (e) {
      AppLogger.e('Failed to fetch posts', e);
      state = state.copyWith(
        status: PostsStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Updates the search query
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Toggles showing only bookmarked posts
  void toggleShowBookmarksOnly() {
    state = state.copyWith(showBookmarksOnly: !state.showBookmarksOnly);
  }

  /// Toggles bookmark status for a post
  Future<void> toggleBookmark(int postId) async {
    final isCurrentlyBookmarked = state.bookmarkedIds.contains(postId);

    try {
      if (isCurrentlyBookmarked) {
        await _removeBookmarkUseCase(postId);
      } else {
        await _addBookmarkUseCase(postId);
      }

      // Update local state
      final newBookmarks = Set<int>.from(state.bookmarkedIds);
      if (isCurrentlyBookmarked) {
        newBookmarks.remove(postId);
      } else {
        newBookmarks.add(postId);
      }

      // Update posts with new bookmark status
      final updatedPosts =
          state.posts.map((postWithUser) {
            if (postWithUser.post.id == postId) {
              return postWithUser.copyWith(
                isBookmarked: !isCurrentlyBookmarked,
              );
            }
            return postWithUser;
          }).toList();

      state = state.copyWith(bookmarkedIds: newBookmarks, posts: updatedPosts);
    } catch (e) {
      AppLogger.e('Failed to toggle bookmark', e);
    }
  }
}
