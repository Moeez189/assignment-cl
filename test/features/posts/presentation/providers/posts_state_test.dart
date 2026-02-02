import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/posts/domain/entities/post.dart';
import 'package:test/features/posts/domain/entities/user.dart';
import 'package:test/features/posts/presentation/providers/posts_state.dart';

void main() {
  late Post post1;
  late Post post2;
  late Post post3;
  late User user1;
  late User user2;
  late PostWithUser postWithUser1;
  late PostWithUser postWithUser2;
  late PostWithUser postWithUser3;

  setUp(() {
    user1 = const User(
      id: 1,
      name: 'Alice',
      username: 'alice',
      email: 'alice@example.com',
    );
    user2 = const User(
      id: 2,
      name: 'Bob',
      username: 'bob',
      email: 'bob@example.com',
    );
    post1 = const Post(
      id: 1,
      userId: 1,
      title: 'First Post Title',
      body: 'Body one',
    );
    post2 = const Post(
      id: 2,
      userId: 2,
      title: 'Second Post',
      body: 'Body two',
    );
    post3 = const Post(
      id: 3,
      userId: 1,
      title: 'Another Title',
      body: 'Body three',
    );
    postWithUser1 = PostWithUser(post: post1, user: user1, isBookmarked: true);
    postWithUser2 = PostWithUser(post: post2, user: user2, isBookmarked: false);
    postWithUser3 = PostWithUser(post: post3, user: user1, isBookmarked: true);
  });

  group('PostsState', () {
    group('filteredPosts', () {
      test('returns all posts when no search query and not filtering bookmarks',
          () {
        final state = PostsState(
          posts: [
            PostWithUser(post: post1, user: user1),
            PostWithUser(post: post2, user: user2),
          ],
        );
        expect(state.filteredPosts.length, 2);
      });

      test('filters by search query (title, case insensitive)', () {
        final state = PostsState(
          posts: [postWithUser1, postWithUser2, postWithUser3],
          searchQuery: 'title',
        );
        expect(state.filteredPosts.length, 2); // "First Post Title", "Another Title"
        expect(state.filteredPosts.map((p) => p.post.id), [1, 3]);
      });

      test('returns empty when search query matches nothing', () {
        final state = PostsState(
          posts: [postWithUser1, postWithUser2],
          searchQuery: 'xyz',
        );
        expect(state.filteredPosts, isEmpty);
      });

      test('filters by bookmarks only when showBookmarksOnly is true', () {
        final state = PostsState(
          posts: [postWithUser1, postWithUser2, postWithUser3],
          bookmarkedIds: {1, 3},
          showBookmarksOnly: true,
        );
        expect(state.filteredPosts.length, 2);
        expect(state.filteredPosts.map((p) => p.post.id), [1, 3]);
      });

      test('combines search query and bookmarks filter', () {
        final state = PostsState(
          posts: [postWithUser1, postWithUser2, postWithUser3],
          searchQuery: 'Post',
          bookmarkedIds: {1},
          showBookmarksOnly: true,
        );
        expect(state.filteredPosts.length, 1);
        expect(state.filteredPosts.first.post.id, 1);
      });
    });

    group('bookmarkedPosts', () {
      test('returns only posts whose id is in bookmarkedIds', () {
        final state = PostsState(
          posts: [postWithUser1, postWithUser2, postWithUser3],
          bookmarkedIds: {2},
        );
        expect(state.bookmarkedPosts.length, 1);
        expect(state.bookmarkedPosts.first.post.id, 2);
      });

      test('returns empty when no bookmarks', () {
        final state = PostsState(
          posts: [postWithUser1, postWithUser2],
          bookmarkedIds: {},
        );
        expect(state.bookmarkedPosts, isEmpty);
      });
    });
  });

  group('PostWithUser', () {
    test('authorName returns user name when user is set', () {
      expect(postWithUser1.authorName, 'Alice');
    });

    test('authorName returns Unknown Author when user is null', () {
      final pw = PostWithUser(post: post1, user: null);
      expect(pw.authorName, 'Unknown Author');
    });
  });
}
