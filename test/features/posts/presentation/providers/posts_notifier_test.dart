import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/core/utils/app_logger.dart';
import 'package:test/features/posts/domain/entities/post.dart';
import 'package:test/features/posts/domain/entities/user.dart';
import 'package:test/features/posts/domain/usecases/add_bookmark_usecase.dart';
import 'package:test/features/posts/domain/usecases/get_bookmarks_usecase.dart';
import 'package:test/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:test/features/posts/domain/usecases/get_users_usecase.dart';
import 'package:test/features/posts/domain/usecases/remove_bookmark_usecase.dart';
import 'package:test/features/posts/presentation/providers/posts_provider.dart';
import 'package:test/features/posts/presentation/providers/posts_state.dart';

class MockGetPostsUseCase extends Mock implements GetPostsUseCase {}

class MockGetUsersUseCase extends Mock implements GetUsersUseCase {}

class MockGetBookmarksUseCase extends Mock implements GetBookmarksUseCase {}

class MockAddBookmarkUseCase extends Mock implements AddBookmarkUseCase {}

class MockRemoveBookmarkUseCase extends Mock implements RemoveBookmarkUseCase {}

void main() {
  late PostsNotifier notifier;
  late MockGetPostsUseCase mockGetPosts;
  late MockGetUsersUseCase mockGetUsers;
  late MockGetBookmarksUseCase mockGetBookmarks;
  late MockAddBookmarkUseCase mockAddBookmark;
  late MockRemoveBookmarkUseCase mockRemoveBookmark;

  setUpAll(() {
    AppLogger.level = Level.off;
  });

  const tPost = Post(
    id: 1,
    userId: 1,
    title: 'Test Post',
    body: 'Body',
  );
  const tUser = User(
    id: 1,
    name: 'Test User',
    username: 'user',
    email: 'user@example.com',
  );

  setUp(() {
    mockGetPosts = MockGetPostsUseCase();
    mockGetUsers = MockGetUsersUseCase();
    mockGetBookmarks = MockGetBookmarksUseCase();
    mockAddBookmark = MockAddBookmarkUseCase();
    mockRemoveBookmark = MockRemoveBookmarkUseCase();
    notifier = PostsNotifier(
      getPostsUseCase: mockGetPosts,
      getUsersUseCase: mockGetUsers,
      getBookmarksUseCase: mockGetBookmarks,
      addBookmarkUseCase: mockAddBookmark,
      removeBookmarkUseCase: mockRemoveBookmark,
    );
  });

  void stubFetchSuccess() {
    when(() => mockGetPosts()).thenAnswer((_) async => [tPost]);
    when(() => mockGetUsers()).thenAnswer((_) async => [tUser]);
    when(() => mockGetBookmarks()).thenAnswer((_) async => {});
  }

  group('PostsNotifier', () {
    group('fetchPosts', () {
      test('should set loading then loaded with posts when success', () async {
        stubFetchSuccess();

        expect(notifier.state.status, PostsStatus.initial);

        final future = notifier.fetchPosts();
        expect(notifier.state.status, PostsStatus.loading);

        await future;

        expect(notifier.state.status, PostsStatus.loaded);
        expect(notifier.state.posts.length, 1);
        expect(notifier.state.posts.first.post.id, 1);
        expect(notifier.state.posts.first.authorName, 'Test User');
        expect(notifier.state.bookmarkedIds, isEmpty);
        verify(() => mockGetPosts()).called(1);
        verify(() => mockGetUsers()).called(1);
        verify(() => mockGetBookmarks()).called(1);
      });

      test('should set error state when getPosts throws', () async {
        when(() => mockGetPosts()).thenThrow(Exception('Network error'));
        when(() => mockGetUsers()).thenAnswer((_) async => [tUser]);
        when(() => mockGetBookmarks()).thenAnswer((_) async => {});

        await notifier.fetchPosts();

        expect(notifier.state.status, PostsStatus.error);
        expect(notifier.state.errorMessage, isNotNull);
        expect(notifier.state.errorMessage, contains('Exception'));
      });
    });

    group('updateSearchQuery', () {
      test('should update searchQuery in state', () {
        expect(notifier.state.searchQuery, '');

        notifier.updateSearchQuery('hello');
        expect(notifier.state.searchQuery, 'hello');

        notifier.updateSearchQuery('');
        expect(notifier.state.searchQuery, '');
      });
    });

    group('toggleShowBookmarksOnly', () {
      test('should toggle showBookmarksOnly', () {
        expect(notifier.state.showBookmarksOnly, false);

        notifier.toggleShowBookmarksOnly();
        expect(notifier.state.showBookmarksOnly, true);

        notifier.toggleShowBookmarksOnly();
        expect(notifier.state.showBookmarksOnly, false);
      });
    });

    group('toggleBookmark', () {
      test('should add bookmark and update state when not bookmarked', () async {
        stubFetchSuccess();
        when(() => mockAddBookmark(any())).thenAnswer((_) async {});
        await notifier.fetchPosts();

        expect(notifier.state.bookmarkedIds, isEmpty);

        await notifier.toggleBookmark(1);

        expect(notifier.state.bookmarkedIds, contains(1));
        expect(notifier.state.posts.first.isBookmarked, true);
        verify(() => mockAddBookmark(1)).called(1);
      });

      test('should remove bookmark and update state when bookmarked', () async {
        stubFetchSuccess();
        when(() => mockAddBookmark(any())).thenAnswer((_) async {});
        when(() => mockRemoveBookmark(any())).thenAnswer((_) async {});
        await notifier.fetchPosts();
        await notifier.toggleBookmark(1); // add
        expect(notifier.state.bookmarkedIds, contains(1));

        await notifier.toggleBookmark(1); // remove

        expect(notifier.state.bookmarkedIds, isNot(contains(1)));
        expect(notifier.state.posts.first.isBookmarked, false);
        verify(() => mockRemoveBookmark(1)).called(1);
      });
    });
  });
}
