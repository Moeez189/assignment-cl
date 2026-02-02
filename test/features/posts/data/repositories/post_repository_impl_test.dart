import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/features/posts/data/datasources/post_local_datasource.dart';
import 'package:test/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:test/features/posts/data/models/post_model.dart';
import 'package:test/features/posts/data/models/user_model.dart';
import 'package:test/features/posts/data/repositories/post_repository_impl.dart';
import 'package:test/features/posts/domain/entities/post.dart';
import 'package:test/features/posts/domain/entities/user.dart';

class MockPostRemoteDataSource extends Mock implements PostRemoteDataSource {}

class MockPostLocalDataSource extends Mock implements PostLocalDataSource {}

void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDataSource mockRemote;
  late MockPostLocalDataSource mockLocal;

  setUp(() {
    mockRemote = MockPostRemoteDataSource();
    mockLocal = MockPostLocalDataSource();
    repository = PostRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  const tPostModel = PostModel(
    id: 1,
    userId: 1,
    title: 'Test',
    body: 'Body',
  );
  const tUserModel = UserModel(
    id: 1,
    name: 'User',
    username: 'user',
    email: 'user@example.com',
  );
  const tPost = Post(
    id: 1,
    userId: 1,
    title: 'Test',
    body: 'Body',
  );
  const tUser = User(
    id: 1,
    name: 'User',
    username: 'user',
    email: 'user@example.com',
  );

  group('getPosts', () {
    test('should return list of Post entities from remote', () async {
      when(() => mockRemote.getPosts()).thenAnswer((_) async => [tPostModel]);

      final result = await repository.getPosts();

      expect(result, [tPost]);
      verify(() => mockRemote.getPosts()).called(1);
    });

    test('should return empty list when remote returns empty', () async {
      when(() => mockRemote.getPosts()).thenAnswer((_) async => []);

      final result = await repository.getPosts();

      expect(result, isEmpty);
      verify(() => mockRemote.getPosts()).called(1);
    });
  });

  group('getUsers', () {
    test('should return list of User entities from remote', () async {
      when(() => mockRemote.getUsers()).thenAnswer((_) async => [tUserModel]);

      final result = await repository.getUsers();

      expect(result, [tUser]);
      verify(() => mockRemote.getUsers()).called(1);
    });

    test('should return empty list when remote returns empty', () async {
      when(() => mockRemote.getUsers()).thenAnswer((_) async => []);

      final result = await repository.getUsers();

      expect(result, isEmpty);
      verify(() => mockRemote.getUsers()).called(1);
    });
  });

  group('getBookmarkedPostIds', () {
    test('should return bookmarked ids from local', () async {
      const ids = {1, 2};
      when(() => mockLocal.getBookmarkedPostIds()).thenAnswer((_) async => ids);

      final result = await repository.getBookmarkedPostIds();

      expect(result, ids);
      verify(() => mockLocal.getBookmarkedPostIds()).called(1);
    });

    test('should return empty set when no bookmarks', () async {
      when(() => mockLocal.getBookmarkedPostIds())
          .thenAnswer((_) async => <int>{});

      final result = await repository.getBookmarkedPostIds();

      expect(result, isEmpty);
      verify(() => mockLocal.getBookmarkedPostIds()).called(1);
    });
  });

  group('addBookmark', () {
    test('should call local addBookmark with post id', () async {
      when(() => mockLocal.addBookmark(any())).thenAnswer((_) async {});

      await repository.addBookmark(1);

      verify(() => mockLocal.addBookmark(1)).called(1);
    });
  });

  group('removeBookmark', () {
    test('should call local removeBookmark with post id', () async {
      when(() => mockLocal.removeBookmark(any())).thenAnswer((_) async {});

      await repository.removeBookmark(1);

      verify(() => mockLocal.removeBookmark(1)).called(1);
    });
  });
}
