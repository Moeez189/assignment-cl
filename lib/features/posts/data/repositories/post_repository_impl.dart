import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_local_datasource.dart';
import '../datasources/post_remote_datasource.dart';

/// Implementation of PostRepository
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Post>> getPosts() async {
    final models = await remoteDataSource.getPosts();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<User>> getUsers() async {
    final models = await remoteDataSource.getUsers();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Set<int>> getBookmarkedPostIds() async {
    return await localDataSource.getBookmarkedPostIds();
  }

  @override
  Future<void> addBookmark(int postId) async {
    await localDataSource.addBookmark(postId);
  }

  @override
  Future<void> removeBookmark(int postId) async {
    await localDataSource.removeBookmark(postId);
  }
}
